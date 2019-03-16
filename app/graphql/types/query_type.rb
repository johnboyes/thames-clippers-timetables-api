require_relative 'route'

module Types
  # Entry points for queries on the schema.
  class QueryType < Types::BaseObject
    field :routing, Types::Route, null: false, description: 'Timetable information for a route' do
      argument :from, Types::Pier, required: true
      argument :to, Types::Pier, required: true
    end

    def routing(from:, to:)
      OpenStruct.new(from: from, to: to, sailings: sailings)
    end

    def sailings
      Array[
        OpenStruct.new(departure_time: '0710', arrival_time: '0744'),
        OpenStruct.new(departure_time: '0805', arrival_time: '0839')
      ]
    end
  end
end
