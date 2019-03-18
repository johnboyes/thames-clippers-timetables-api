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
              { 'departureTime' => '0559', 'arrivalTime' => '0639' },
              { 'departureTime' => '0617', 'arrivalTime' => '0656' },
              { 'departureTime' => '0647', 'arrivalTime' => '0729' },
              { 'departureTime' => '0717', 'arrivalTime' => '0759' },
              { 'departureTime' => '0748', 'arrivalTime' => '0822' },
              { 'departureTime' => '0802', 'arrivalTime' => '0841' },
              { 'departureTime' => '0832', 'arrivalTime' => '0911' },
              { 'departureTime' => '0905', 'arrivalTime' => '0945' },
              { 'departureTime' => '0934', 'arrivalTime' => '1020' },
              { 'departureTime' => '0952', 'arrivalTime' => '1038' },
              { 'departureTime' => '1722', 'arrivalTime' => '1808' },
              { 'departureTime' => '1757', 'arrivalTime' => '1838' },
              { 'departureTime' => '1827', 'arrivalTime' => '1907' },
              { 'departureTime' => '1847', 'arrivalTime' => '1927' },
              { 'departureTime' => '1907', 'arrivalTime' => '1947' },
              { 'departureTime' => '1927', 'arrivalTime' => '2007' },
              { 'departureTime' => '1947', 'arrivalTime' => '2027' },
              { 'departureTime' => '2002', 'arrivalTime' => '2042' },
              { 'departureTime' => '2017', 'arrivalTime' => '2057' },
              { 'departureTime' => '2032', 'arrivalTime' => '2112' },
              { 'departureTime' => '2052', 'arrivalTime' => '2132' },
              { 'departureTime' => '2117', 'arrivalTime' => '2157' },
              { 'departureTime' => '2137', 'arrivalTime' => '2217' }
            ]
          }
      }
    )
  end
end
