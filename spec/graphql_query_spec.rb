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
              { 'departureTime' => '0617',  'arrivalTime' => '0700' },
              { 'departureTime' => '0647',  'arrivalTime' => '0730' },
              { 'departureTime' => '0717',  'arrivalTime' => '0800' },
              { 'departureTime' => '0802',  'arrivalTime' => '0848' },
              { 'departureTime' => '0837',  'arrivalTime' => '0922' },
              { 'departureTime' => '0907',  'arrivalTime' => '0953' },
              { 'departureTime' => '0937',  'arrivalTime' => '1028' },
              { 'departureTime' => '0957',  'arrivalTime' => '1047' },
              { 'departureTime' => '1732',  'arrivalTime' => '1822' },
              { 'departureTime' => '1757',  'arrivalTime' => '1840' },
              { 'departureTime' => '1827',  'arrivalTime' => '1910' },
              { 'departureTime' => '1847',  'arrivalTime' => '1930' },
              { 'departureTime' => '1907',  'arrivalTime' => '1950' },
              { 'departureTime' => '1927',  'arrivalTime' => '2010' },
              { 'departureTime' => '1947',  'arrivalTime' => '2030' },
              { 'departureTime' => '2007',  'arrivalTime' => '2048' },
              { 'departureTime' => '0748',  'arrivalTime' => '0824' },
              { 'departureTime' => '2027',  'arrivalTime' => '2110' },
              { 'departureTime' => '2047',  'arrivalTime' => '2127' },
              { 'departureTime' => '2107',  'arrivalTime' => '2150' },
              { 'departureTime' => '2127',  'arrivalTime' => '2210' },
              { 'departureTime' => '2152',  'arrivalTime' => '2235' }
            ]
          }
      }
    )
  end
end
