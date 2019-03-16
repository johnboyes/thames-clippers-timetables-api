require 'rails_helper'

# Helper methods for GraphQL specs
module GraphQLHelpers
  def request_sailing_times(query)
    post '/graphql', params: { 'query' => query }
  end
end
