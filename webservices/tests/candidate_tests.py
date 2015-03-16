from .common import ApiBaseTest
import unittest


class CandidateFormatTest(ApiBaseTest):
    """Test/Document expected formats"""
    def test_candidate(self):
        """Compare results to expected fields."""
        # @todo - use a factory rather than the test data
        response = self._response('/candidate/H0VA08040')
        self.assertResultsEqual(
            response['pagination'],
            {'count': 20, 'page': 1, 'pages': 1, 'per_page': 20})
        # we are showing the full history rather than one result
        self.assertEqual(len(response['results']), 20)

        result = response['results'][0]
        self.assertEqual(result['candidate_id'], 'H0VA08040')
        self.assertEqual(result['form_type'], 'F2Z')
        # @todo - check for a value for expire_data
        self.assertEqual(result['expire_date'], None)
        # most recent record should be first
        self.assertEqual(result['load_date'], '2013-04-24 00:00:00')
        self.assertResultsEqual(result['name'], 'MORAN, JAMES P. JR.')
        #address
        self.assertEqual(result['address_city'], 'ALEXANDRIA')
        self.assertEqual(result['address_state'], 'VA')
        self.assertEqual(result['address_street_1'], '311 NORTH WASHINGTON STREET')
        self.assertEqual(result['address_street_2'], 'SUITE 200L')
        self.assertEqual(result['address_zip'], '22314')
        self.assertEqual(16, len(result['committees']))
        # office
        self.assertResultsEqual(result['office'], 'H')
        self.assertResultsEqual(result['district'],'08')
        self.assertResultsEqual(result['state'], 'VA')
        self.assertResultsEqual(result['office_full'], 'House')
        # From party_mapping
        self.assertResultsEqual(result['party'], 'DEM')
        self.assertResultsEqual(result['party_full'], 'Democratic Party')
        # From status_mapping
        self.assertResultsEqual(result['active_through'], 2014)
        self.assertResultsEqual(result['candidate_inactive'], 'Y')
        self.assertResultsEqual(result['candidate_status'], 'C')
        self.assertResultsEqual(result['incumbent_challenge'], 'I')
                # Expanded from candidate_status
        self.assertResultsEqual(result['candidate_status_full'], 'Statutory candidate')


    @unittest.skip("Fix later once we've figured out how to fix committee cardinality")
    def test_candidate_committees(self):
        """Compare results to expected fields."""
        # @todo - use a factory rather than the test data
        response = self._response('/candidate/H0VA08040')
        committees = response['results'][0]['committees']
        self.prettyPrint(committees)
        self.assertResultsEqual(committees,
            [{
                # From cand_committee_format_mapping
                'committee_designation': 'P',
                'committee_designation_full': 'Principal campaign committee',
                'committee_id': 'C00241349',
                'committee_name': 'MORAN FOR CONGRESS',
                'committee_type': 'H',
                'committee_type_full': 'House',
                'election_year': 2014,
                'expire_date': None,
                'link_date': '2007-10-12 13:38:33',

            }])

        # The above candidate is missing a few fields
        response = self._response('/candidate/P20003984')
        committee = response['results'][0]['committees'][1]

        self.assertResultsEqual(committee['committee_type'], 'I')
        self.assertResultsEqual(committee['committee_type_full'], 'Independent Expenditor (Person or Group)')


    def _results(self, qry):
        response = self._response(qry)
        return response['results']

    def test_fields(self):
        # testing key defaults
        response = self._results('/candidate/P80003338?year=2008')
        response = response[0]

        self.assertEquals(response['name'], 'OBAMA, BARACK')

        fields = ('party', 'party_full', 'state', 'district', 'incumbent_challenge_full', 'incumbent_challenge', 'candidate_status', 'candidate_status_full', 'office', 'active_through')

        for field in fields:
            print field
            print response[field]
            self.assertEquals(response.has_key(field), True)

    def test_extra_fields(self):
        response = self._results('/candidate/P80003338?year=2008')
        self.assertIn('committees', response[0])
        self.assertIn('PO BOX 8102', response[0]['address_street_1'])
        self.assertIn('60680',response[0]['address_zip'])
        # testing for year sensitivity
        self.assertIn('O', response[0]['incumbent_challenge'])

    def test_candidate_committes(self):
        response = self._results('/candidate/P80003338?year=*')

        fields = ('committee_id', 'committee_designation', 'committee_designation_full', 'committee_type', 'committee_type_full', 'committee_name')

        election = response[0]['committees'][0]
        print election
        for field in fields:
            print field
            self.assertEquals(election.has_key(field), True)

    def test_cand_filters(self):
        # checking one example from each field
        orig_response = self._response('/candidates')
        original_count = orig_response['pagination']['count']

        filter_fields = (
            ('office','H'),
            ('district', '00,02'),
            ('state', 'CA'),
            ('name', 'Obama'),
            ('party', 'DEM'),
            ('year', '2012,2014'),
            ('candidate_id', 'H0VA08040,P80003338'),
        )

        for field, example in filter_fields:
            page = "/candidates?%s=%s" % (field, example)
            print page
            # returns at least one result
            results = self._results(page)
            self.assertGreater(len(results), 0)
            # doesn't return all results
            response = self._response(page)
            self.assertGreater(original_count, response['pagination']['count'])


    def test_name_endpoint_returns_unique_candidates_and_committees(self):
        results = self._results('/names?q=obama')
        cand_ids = [r['candidate_id'] for r in results if r['candidate_id']]
        self.assertEqual(len(cand_ids), len(set(cand_ids)))
        cmte_ids = [r['committee_id'] for r in results if r['committee_id']]
        self.assertEqual(len(cmte_ids), len(set(cmte_ids)))






