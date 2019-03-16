module Types
  # Enumeration of all the Thames Clippers piers
  class Pier < Types::BaseEnum
    piers = %w[WANDSWORTH_RIVERSIDE_QUARTER BLACKFRIARS]
    piers.each do |pier|
      value pier
    end
  end
end
