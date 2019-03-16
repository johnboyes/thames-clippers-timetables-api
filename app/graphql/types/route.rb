# require_relative 'sailing_type'

module Types
  # A route between any two piers
  class Route < Types::BaseObject
    field :from, String, null: false
    field :to, String, null: false
    field :sailings, [Types::Sailing], null: false
  end
end
