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
              { 'departureTime' => '0637',  'arrivalTime' => '0725' },
              { 'departureTime' => '0707',  'arrivalTime' => '0755' },
              { 'departureTime' => '0727',  'arrivalTime' => '0814' },
              { 'departureTime' => '0747',  'arrivalTime' => '0833' },
              { 'departureTime' => '0807',  'arrivalTime' => '0853' },
              { 'departureTime' => '0832',  'arrivalTime' => '0920' },
              { 'departureTime' => '0912',  'arrivalTime' => '1006' },
              { 'departureTime' => '1713',  'arrivalTime' => '1804' },
              { 'departureTime' => '1757',  'arrivalTime' => '1847' },
              { 'departureTime' => '1822',  'arrivalTime' => '1912' },
              { 'departureTime' => '1857',  'arrivalTime' => '1946' },
              { 'departureTime' => '1917',  'arrivalTime' => '2004' },
              { 'departureTime' => '1952',  'arrivalTime' => '2039' },
              { 'departureTime' => '2023',  'arrivalTime' => '2107' },
              { 'departureTime' => '2053',  'arrivalTime' => '2143' },
              { 'departureTime' => '2118',  'arrivalTime' => '2202' }
            ]
          }
      }
    )
  end
end
