#!/usr/bin/env python
import os
import glob

import json

def load_house_senate(data):
    results = data['results']
    year = data['election_year']
    print year

    districts = []
    everything = []
    candidates = []
    test = {}

    for line in results:
        kind = None
        for key in line:
            # identifying individual results
            candidate_listing = ['CANDIDATE NAME', 'CANDIDATE NAME (Last, First)','LAST NAME, FIRST']
            if key in candidate_listing:
                if line[key] :
                    kind = 'candidate'
                    candidate_key = key

            # identifying totals
            elif "TOTAL" in key:
                # identifying state totals
                if type(line[key]) is unicode:
                    if 'STATE' in line[key].upper():
                        kind = 'state'

                    # district totals
                    # in 2012 it is just D
                    if 'DISTRICT' in line[key].upper() or 'D' == line[key]:
                        kind = 'district'
                        real_district_key = key

                    # party totals
                    if 'PARTY' in line[key].upper():
                        kind = 'party total'



        # needed for the different categories
        state = line['STATE']
        if 'DISTRICT' in line:
            district = line['DISTRICT']
        else:
            district = line['D']

        if 'PRIMARY VOTES' in line:
            primary = line['PRIMARY VOTES']
        if 'PRIMARY' in line:
            primary = line['PRIMARY']


        if 'GENERAL VOTES ' in line:
            general = line['GENERAL VOTES ']
        if 'GENERAL VOTES' in line:
            general = line['GENERAL VOTES']
        if 'GENERAL' in line:
            general = line['GENERAL']
        if 'GENERAL ' in line:
            general = line['GENERAL ']

        if kind == 'district':
            # print year
            # print line['TOTAL VOTES']
            district = {
                'state': state,
                'district': district,
                'general': general,
                'primary': primary,
                'year':year
            }
            districts.append(district)

        if kind == 'candidate':
            candidate = {
                'name': line[candidate_key],
                'state': state,
                'district': district,
                'general': general,
                'primary': primary,
                'year':year
            }
            test[year] = candidate
            candidates.append(candidate)





    # testing
    # everything.append(districts)
    # everything.append(candidates)
    print test


for file_name in glob.glob("data/*.json"):
    print file_name
    json_data = open(file_name)
    data = json.load(json_data)
    load_house_senate(data)



