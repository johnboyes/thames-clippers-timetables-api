require_relative 'support/helpers/graphql_helper'
require_relative 'support/custom_matchers/eq_json_matcher'

RSpec.configure do |c|
  c.include GraphQLHelpers
end

RSpec.describe 'graphql', type: :request do
  it 'returns thames clipper sailing times' do
    execute_graphql_query <<~QUERY
      {
        routing(from: WANDSWORTH_RIVERSIDE_QUARTER, to: BLACKFRIARS) {
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
            'from' => 'WANDSWORTH_RIVERSIDE_QUARTER',
            'to' => 'BLACKFRIARS',
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
