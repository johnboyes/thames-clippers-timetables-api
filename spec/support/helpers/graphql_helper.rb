require 'rails_helper'

# Helper methods for GraphQL specs
module GraphQLHelpers
  def execute_graphql_query(query)
    post '/graphql', params: { 'query' => query }
  end
end
