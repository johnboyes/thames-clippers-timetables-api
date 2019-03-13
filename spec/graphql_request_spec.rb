require_relative 'support/helpers/graphql_helper'
require_relative 'support/custom_matchers/eq_json_matcher'

RSpec.configure do |c|
  c.include GraphQLHelpers
end

RSpec.describe 'graphql', type: :request do
  it 'returns thames clipper sailing times' do
    execute_graphql_query <<~QUERY
      {
        testField
      }
    QUERY

    expect(response).to eq_json(
      'data' => { 'testField' => 'Hello World!' }
    )
  end
end
