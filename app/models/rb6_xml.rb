require 'nikkou'
require 'nokogiri'
require 'zip'
require 'open-uri'

# Parsed XML Thames Clippers RB6 timetable
class RB6XML
  TIMETABLES_DIR = "#{Rails.root}/tmp/timetables".freeze
  TIMETABLES_ZIP = 'journey-planner-timetables.zip'.freeze
  TIMETABLES_BASE_URL = "http://tfl.gov.uk/tfl/syndication/feeds/#{TIMETABLES_ZIP}".freeze
  TIMETABLES_QUERY_STRING = "?app_id=#{ENV['TFL_APP_ID']}&app_key=#{ENV['TFL_APP_KEY']}".freeze
  TIMETABLES_URL = "#{TIMETABLES_BASE_URL}#{TIMETABLES_QUERY_STRING}".freeze

  def initialize
    puts 'parsing xml'
    rb6_filename = download_rb6_xml
    @parsed_xml = Nokogiri::XML(File.open("#{TIMETABLES_DIR}/#{rb6_filename}")).remove_namespaces!
  end

  def vehicle_journeys
    @parsed_xml.xpath('TransXChange/VehicleJourneys/VehicleJourney')
  end

  def departure_time(vehicle_journey)
    vehicle_journey.xpath('DepartureTime').text
  end

  def timing_links(vehicle_journey)
    # TODO: should I make this method more efficient?
    section_id = journey_pattern(vehicle_journey).xpath('JourneyPatternSectionRefs').text
    sections = @parsed_xml.xpath('TransXChange/JourneyPatternSections/JourneyPatternSection')
    section = sections.attr_equals('id', section_id)
    section.xpath('JourneyPatternTimingLink')
  end

  def duration_in_seconds(timing_link)
    ActiveSupport::Duration.parse(timing_link.xpath('RunTime').text)
  end

  def journey_pattern(vehicle_journey)
    # TODO: should I make this method more efficient?
    journey_pattern_id = vehicle_journey.xpath('JourneyPatternRef').text
    @parsed_xml.attr_equals('id', journey_pattern_id)
  end

  def from(journey_pattern_timing_link)
    from_or_to(journey_pattern_timing_link, 'From')
  end

  def to(journey_pattern_timing_link)
    from_or_to(journey_pattern_timing_link, 'To')
  end

  def from_or_to(journey_pattern_timing_link, from_or_to)
    stop_id = journey_pattern_timing_link.xpath("#{from_or_to}/StopPointRef").text
    pier = piers.xpath('AtcoCode').text_equals(stop_id).first.parent
    pier_name(pier)
  end

  def pier_names
    piers.xpath('Descriptor/CommonName')
  end

  def piers
    @parsed_xml.xpath('TransXChange/StopPoints/StopPoint')
  end

  def pier_name(pier)
    pier.xpath('Descriptor/CommonName').text
  end

  private

  def download_rb6_xml
    FileUtils.mkdir_p(TIMETABLES_DIR)
    FileUtils.rm_rf(Dir["#{TIMETABLES_DIR}/*"])
    download = URI.open(TIMETABLES_URL)
    IO.copy_stream(download, "#{TIMETABLES_DIR}/#{TIMETABLES_ZIP}")
    river_zip_filename = unzip_file("#{TIMETABLES_DIR}/#{TIMETABLES_ZIP}", TIMETABLES_DIR, 'CABLE')
    File.delete("#{TIMETABLES_DIR}/#{TIMETABLES_ZIP}")
    rb6_filename = unzip_file("#{TIMETABLES_DIR}/#{river_zip_filename}", TIMETABLES_DIR, 'RB6')
    File.delete("#{TIMETABLES_DIR}/#{river_zip_filename}")
    rb6_filename
  end

  def unzip_file(file, destination, match)
    Zip::File.open(file) do |zip_file|
      file = zip_file.find { |f| f.name.include?(match) }
      file_path = File.join(destination, file.name)
      FileUtils.mkdir_p(File.dirname(file_path))
      file.extract(file_path)
      file.name
    end
  end
end
