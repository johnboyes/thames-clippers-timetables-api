require_relative 'route'
require_relative '../../models/timetables'

module Types
  # Entry points for queries on the schema.
  class QueryType < Types::BaseObject
    include Timetables
    field :routing, Types::Route, null: false, description: 'Timetable information for a route' do
      argument :from, Types::Pier, required: true
      argument :to, Types::Pier, required: true
    end

    def routing(from:, to:)
      OpenStruct.new(from: from, to: to, sailings: Timetables.sailings(from: from, to: to))
    end
  end
end
