require_relative '../../models/timetables'

module Types
  # Enumeration of all the Thames Clippers piers
  class Pier < Types::BaseEnum
    include Timetables
    Timetables.pier_names.each { |pier| value pier }
  end
end
