# Thames Clippers timetables data, retrieved from TFL's open data APIs
module Timetables
  extend self

  def pier_names
    Set.new(rb6_xml.pier_names) { |name| enumize(name.text) }
  end

  def all_sailings
    rb6_xml.vehicle_journeys.map { |journey| sailing(journey) }
  end

  def sailing(journey)
    timing_links = rb6_xml.timing_links(journey)
    sailing = [sailing_stop(departure_time(journey), rb6_xml.from(timing_links[0]))]
    timing_links.each_with_object(sailing) do |timing_link, s|
      departure_time = s.last.departure_time + rb6_xml.duration_in_seconds(timing_link)
      s << sailing_stop(departure_time, rb6_xml.to(timing_link))
    end
  end

  def sailing_stop(departure_time, pier)
    OpenStruct.new(departure_time: departure_time, pier: enumize(pier))
  end

  def departure_time(journey)
    Time.parse(rb6_xml.departure_time(journey))
  end

  def sailings(from:, to:)
    all_sailings.each_with_object([]) do |sailing, matched_sailings|
      matched_sailings << sailing_from_to(sailing, from, to) if from_a_to_b? sailing, from, to
    end.sort_by(&:departure_time)
  end

  def sailing_from_to(sailing, from, to)
    departure_time = print_time(sailing.find { |stop| stop.pier == from }.departure_time)
    arrival_time = print_time(sailing.find { |stop| stop.pier == to }.departure_time)
    OpenStruct.new(departure_time: departure_time, arrival_time: arrival_time)
  end

  def from_a_to_b?(sailing, from, to)
    selected_from = sailing.find { |stop| stop.pier == from }
    selected_to = sailing.find { |stop| stop.pier == to }
    selected_from && selected_to && (selected_from.departure_time < selected_to.departure_time)
  end

  def print_time(time)
    time.strftime('%H%M')
  end

  private

  def enumize(name)
    name.parameterize(separator: '_').upcase
  end

  def rb6_xml
    @rb6_xml ||= RB6XML.new
  end
end
