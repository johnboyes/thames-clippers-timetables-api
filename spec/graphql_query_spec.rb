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
              { 'departureTime' => '0550',  'arrivalTime' => '0634' },
              { 'departureTime' => '0612',  'arrivalTime' => '0658' },
              { 'departureTime' => '0642',  'arrivalTime' => '0728' },
              { 'departureTime' => '0712',  'arrivalTime' => '0755' },
              { 'departureTime' => '0743',  'arrivalTime' => '0823' },
              { 'departureTime' => '0802',  'arrivalTime' => '0850' },
              { 'departureTime' => '0837',  'arrivalTime' => '0922' },
              { 'departureTime' => '0907',  'arrivalTime' => '0955' },
              { 'departureTime' => '0937',  'arrivalTime' => '1028' },
              { 'departureTime' => '1007',  'arrivalTime' => '1057' },
              { 'departureTime' => '1732',  'arrivalTime' => '1822' },
              { 'departureTime' => '1757',  'arrivalTime' => '1840' },
              { 'departureTime' => '1827',  'arrivalTime' => '1910' },
              { 'departureTime' => '1847',  'arrivalTime' => '1930' },
              { 'departureTime' => '1907',  'arrivalTime' => '1950' },
              { 'departureTime' => '1927',  'arrivalTime' => '2010' },
              { 'departureTime' => '1947',  'arrivalTime' => '2030' },
              { 'departureTime' => '2007',  'arrivalTime' => '2049' },
              { 'departureTime' => '2027',  'arrivalTime' => '2111' },
              { 'departureTime' => '2047',  'arrivalTime' => '2129' },
              { 'departureTime' => '2107',  'arrivalTime' => '2150' },
              { 'departureTime' => '2127',  'arrivalTime' => '2211' },
              { 'departureTime' => '2152',  'arrivalTime' => '2235' }
            ]
          }
      }
    )
  end
end
