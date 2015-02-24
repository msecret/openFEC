#!/usr/bin/env python
import os
import sys

import json
import uuid
import xlrd
import lxml.html
import requests


LIBRARY = "http://www.fec.gov/general/library.shtml"


def lxmlize(url):
    req = requests.get(url)
    page = lxml.html.fromstring(req.content)
    page.make_links_absolute(url)
    return page


def rows(sheet):
    header = [x.value for x in sheet.row(0)]
    for i in range(1, sheet.nrows):
        yield dict(zip(header, (x.value for x in sheet.row(i))))


def scrape_house_senate_results(sheet):
    for row in rows(sheet):
        yield row

def scrape_xls(req):
    book = xlrd.open_workbook(file_contents=req.content)
    dispatch = {
        "house & senate res": scrape_house_senate_results,
        "house and senate res": scrape_house_senate_results,
    }
    for sheet in book.sheets():
        name = sheet.name.lower()
        print name
        for k, v in dispatch.items():
            if k in name:
                return v(sheet)
    raise ValueError("Unhandled workbook")


def scrape_html(page, year):
    results = []
    for spreadsheet in page.xpath(
        "//a[contains(@href, 'results') "
            "and contains(@href, '.xls')]/@href"
    ):
        data = requests.get(spreadsheet)
        for x in scrape_xls(data):
            results.append(x)
    yield {'results': results, 'election_year': year}


def save(data):
    for el in data:
        with open("data/{}.json".format(uuid.uuid4()), 'w') as fd:
            json.dump(el, fd)


def scrape():
    if os.path.exists("data"):
        raise ValueError("Data directory exists; please clear it :)")
    os.mkdir("data")

    lib = lxmlize(LIBRARY)
    for page in set(lib.xpath("//a[contains(@href, 'federalelections')]/@href")):
        year = page[28:32]
        # I am pretty sure the pdfs don't have additional information
        if page.endswith(".pdf"):
            continue  # XXX: Write a PDF parser
        save(scrape_html(lxmlize(page), int(year)))


if __name__ == "__main__":
    scrape(*sys.argv[1:])
