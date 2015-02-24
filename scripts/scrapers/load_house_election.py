#!/usr/bin/env python
import os
import glob

import json

def load_house_senate(data):
    results = data['results']
    year = data['election_year']
    print year

    for line in results:
        kind = None
        for key in line:
            # identifying individual results
            if 'LAST' in key:
                if not line[key] != '':
                    kind = 'candidate'

            # identifying totals
            elif "TOTAL" in key:
                # identifying state totals
                if type(line[key]) is unicode:
                    if 'STATE' in line[key].upper():
                        kind = 'state'

                    # district totals
                    if 'DISTRICT' in line[key].upper():
                        kind = 'district'
                        real_key = key
                        print

                    # party totals
                    if 'PARTY' in line[key].upper():
                        kind = 'party total'



        if kind == 'district':
            print line
            print line[real_key]
            print year
            print line['TOTAL VOTES']
            print {'primary': line['PRIMARY']}
            print {'general': line['GENERAL']}





for file_name in glob.glob("data/*.json"):
    print file_name
    json_data = open(file_name)
    data = json.load(json_data)
    load_house_senate(data)



