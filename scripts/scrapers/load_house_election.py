#!/usr/bin/env python
import os
import glob

import json

everything = {}

def load_house_senate(data):
    candidates = []
    districts = []
    h_candidates = []
    s_candidates = []
    results = data['results']
    year = data['election_year']
    everything[year] = {}

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
            if "TOTAL" in key:
                # identifying state totals
                if type(line[key]) is unicode:
                    if 'STATE' in line[key].upper():
                        kind = 'state'

                    # district totals
                    # in 2012 it is just D
                    if 'DISTRICT' in line[key].upper() or 'D' == line[key]:
                        kind = 'district'
                        real_district_key = key
                    if 'SENATE' in line[key].upper():
                        kind = 'district'
                        real_district_key = key

                    # party totals
                    if 'PARTY' in line[key].upper():
                        kind = 'party total'

            if "FEC ID" in key:
                id_key = key

            if "RUNOFF" in key and '%' not in key:
                runoff_key = key



        # needed for the different categories
        state = line['STATE']
        if 'DISTRICT' in line:
            dist= line['DISTRICT']
        else:
            dist = line['D']

        if 'PRIMARY VOTES' in line:
            primary = line['PRIMARY VOTES']
        if 'PRIMARY' in line:
            primary = line['PRIMARY']
        if primary == 'Unopposed':
            primary = ''
            unopposed_primary = True
        else:
            unopposed_primary = False


        if 'GENERAL VOTES ' in line:
            general = line['GENERAL VOTES ']
        if 'GENERAL VOTES' in line:
            general = line['GENERAL VOTES']
        if 'GENERAL' in line:
            general = line['GENERAL']
        if 'GENERAL ' in line:
            general = line['GENERAL ']
        if general == 'Unopposed':
            general = ''
            unopposed_general = True
        else:
            unopposed_general = False

        if runoff_key:
            runoff = line[runoff_key]
            other = ['Combined Parties', 'Combined Parties:', 'Combined Parties: ', 'n/a']
            if runoff in other:
                runoff = ''

        # create
        if kind == 'district':
            district_record = {
                'state': state,
                'district': dist,
                'general': general,
                'primary': primary,
                'runoff': runoff,
                'year':year
            }
            districts.append(district_record)

        if kind == 'candidate':
            # just going to take the valid keys
            if len(line[id_key]) == 9:
                fec_id = line[id_key]
            else:
                fec_id = None

            candidate = {
                'name': line[candidate_key],
                'state': state,
                'general': general,
                'primary': primary,
                'year':year,
                'candidate_id': fec_id,
                'unopposed_general': unopposed_general,
                'unopposed_primary': unopposed_primary
            }

            if type(dist) == unicode and "S" in dist:
                candidate['office'] = 'Senate'
                s_candidates.append(candidate)
                candidates.append(candidate)
            else:
                if dist == 'H':
                    # total votes for a house
                    pass
                else:
                    if dist and len(str(dist)) > 2:
                        dist = str(dist)[:2]
                    candidate['district'] = int(dist)
                    candidate['office'] = 'House'
                    h_candidates.append(candidate)
                    candidates.append(candidate)

    # testing
    everything[year]['districts'] = districts
    everything[year]['house'] = h_candidates
    everything[year]['senate'] = s_candidates

    print h_candidates


for file_name in glob.glob("data/*.json"):
    print file_name
    json_data = open(file_name)
    data = json.load(json_data)
    load_house_senate(data)





