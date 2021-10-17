require_relative 'support/helpers/graphql_helper'
require_relative 'support/custom_matchers/eq_json_matcher'

RSpec.configure do |c|
  c.include GraphQLHelpers
end

RSpec.describe 'graphql', type: :request do
  it 'returns thames clipper sailing times' do
    request_sailing_times <<~QUERY
      {
        routing(from: WANDSWORTH_RIVERSIDE_QUARTER_PIER, to: BLACKFRIARS_PIER) {
          from
          to
          sailings {
            departureTime
            arrivalTime
          }
        }
      }
    QUERY

    expect(response).to eq_json(
      'data' => {
        'routing' =>
          {
            'from' => 'WANDSWORTH_RIVERSIDE_QUARTER_PIER',
            'to' => 'BLACKFRIARS_PIER',
            'sailings' => [
              { 'departureTime' => '0637',  'arrivalTime' => '0722' },
              { 'departureTime' => '0707',  'arrivalTime' => '0752' },
              { 'departureTime' => '0737',  'arrivalTime' => '0822' },
              { 'departureTime' => '0807',  'arrivalTime' => '0852' },
              { 'departureTime' => '0837',  'arrivalTime' => '0923' },
              { 'departureTime' => '0907',  'arrivalTime' => '0952' },
              { 'departureTime' => '0937',  'arrivalTime' => '1027' },
              { 'departureTime' => '1022',  'arrivalTime' => '1116' },
              { 'departureTime' => '1717',  'arrivalTime' => '1805' },
              { 'departureTime' => '1752',  'arrivalTime' => '1840' },
              { 'departureTime' => '1822',  'arrivalTime' => '1909' },
              { 'departureTime' => '1847',  'arrivalTime' => '1931' },
              { 'departureTime' => '1922',  'arrivalTime' => '2009' },
              { 'departureTime' => '1947',  'arrivalTime' => '2031' },
              { 'departureTime' => '2015',  'arrivalTime' => '2058' },
              { 'departureTime' => '2038',  'arrivalTime' => '2126' },
              { 'departureTime' => '2110',  'arrivalTime' => '2153' }
            ]
          }
      }
    )
  end
end
