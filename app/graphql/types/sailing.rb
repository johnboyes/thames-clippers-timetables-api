module Types
  # One scheduled sailing e.g. Wandsworth Riverside Quarter to Blackfriars at 07.10
  class Sailing < Types::BaseObject
    field :departure_time, String, null: false
    field :arrival_time, String, null: false
  end
end
