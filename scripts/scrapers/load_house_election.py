#!/usr/bin/env python
import os
import glob

import json

everything = []

def load_house_senate(data):
    candidates = []
    districts = []
    h_candidates = []
    s_candidates = []
    results = data['results']
    year = data['election_year']

    for line in results:
        kind = None
        for key in line:
            # identifying individual results
            candidate_listing = ['CANDIDATE NAME', 'CANDIDATE NAME (Last, First)','LAST NAME, FIRST']
            if key in candidate_listing:
                if 'DISTRICT' in line[key].upper():
                    pass # these are titles
                elif line[key]:
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
                'general': general,
                'primary': primary,
                'year':year
            }

            if type(district) == unicode and "S" in district:
                candidate['office'] = 'Senate'
                s_candidates.append(candidate)
                candidates.append(candidate)
            else:
                if district == 'H':
                    # total votes for a house in a Pennsylvania in 2008
                    pass
                else:
                    if district and len(str(district)) > 2:
                        district = str(district)[:2]
                    candidate['district'] = int(district)

                    candidate['office'] = 'House'
                    h_candidates.append(candidate)
                    candidates.append(candidate)


    # testing
    everything.append(districts)
    everything.append(h_candidates)
    everything.append(s_candidates)


for file_name in glob.glob("data/*.json"):
    print file_name
    json_data = open(file_name)
    data = json.load(json_data)
    load_house_senate(data)

# print everything


