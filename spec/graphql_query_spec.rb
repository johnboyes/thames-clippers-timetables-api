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
              { 'departureTime' => '0707',  'arrivalTime' => '0754' },
              { 'departureTime' => '0737',  'arrivalTime' => '0825' },
              { 'departureTime' => '0812',  'arrivalTime' => '0900' },
              { 'departureTime' => '0907',  'arrivalTime' => '0955' },
              { 'departureTime' => '0947',  'arrivalTime' => '1036' },
              { 'departureTime' => '1022',  'arrivalTime' => '1112' },
              { 'departureTime' => '1747',  'arrivalTime' => '1834' },
              { 'departureTime' => '1817',  'arrivalTime' => '1903' },
              { 'departureTime' => '1847',  'arrivalTime' => '1933' },
              { 'departureTime' => '1907',  'arrivalTime' => '1952' },
              { 'departureTime' => '1937',  'arrivalTime' => '2022' },
              { 'departureTime' => '1957',  'arrivalTime' => '2042' }
            ]
          }
      }
    )
  end
end
