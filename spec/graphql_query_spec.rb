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
              { 'departureTime' => '0637',  'arrivalTime' => '0723' },
              { 'departureTime' => '0707',  'arrivalTime' => '0754' },
              { 'departureTime' => '0727',  'arrivalTime' => '0813' },
              { 'departureTime' => '0752',  'arrivalTime' => '0837' },
              { 'departureTime' => '0807',  'arrivalTime' => '0853' },
              { 'departureTime' => '0832',  'arrivalTime' => '0920' },
              { 'departureTime' => '0912',  'arrivalTime' => '1005' },
              { 'departureTime' => '1717',  'arrivalTime' => '1803' },
              { 'departureTime' => '1752',  'arrivalTime' => '1840' },
              { 'departureTime' => '1817',  'arrivalTime' => '1904' },
              { 'departureTime' => '1847',  'arrivalTime' => '1931' },
              { 'departureTime' => '1917',  'arrivalTime' => '2004' },
              { 'departureTime' => '1947',  'arrivalTime' => '2031' },
              { 'departureTime' => '2020',  'arrivalTime' => '2103' },
              { 'departureTime' => '2038',  'arrivalTime' => '2126' },
              { 'departureTime' => '2110',  'arrivalTime' => '2153' }
            ]
          }
      }
    )
  end
end
