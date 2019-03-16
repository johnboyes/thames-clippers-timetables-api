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
              {
                'departureTime' => '0710',
                'arrivalTime' => '0744'
              },
              {
                'departureTime' => '0805',
                'arrivalTime' => '0839'
              }
            ]
          }
      }
    )
  end
end
