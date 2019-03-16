require 'nikkou'
require 'nokogiri'
require 'zip'
require 'open-uri'

# Parsed XML Thames Clippers RB6 timetable
class RB6XML
  TIMETABLES_DIR = "#{Rails.root}/tmp/timetables".freeze
  TIMETABLES_ZIP = 'journey-planner-timetables.zip'.freeze
  TIMETABLES_BASE_URL = "http://data.tfl.gov.uk/tfl/syndication/feeds/#{TIMETABLES_ZIP}".freeze
  TIMETABLES_QUERY_STRING = "?app_id=#{ENV['TFL_APP_ID']}&app_key=#{ENV['TFL_APP_KEY']}".freeze
  TIMETABLES_URL = "#{TIMETABLES_BASE_URL}#{TIMETABLES_QUERY_STRING}".freeze

  def initialize
    rb6_filename = download_rb6_xml
    @parsed_xml = Nokogiri::XML(File.open("#{TIMETABLES_DIR}/#{rb6_filename}")).remove_namespaces!
  end

  attr_reader :parsed_xml

  private

  def download_rb6_xml
    FileUtils.mkdir_p(TIMETABLES_DIR)
    FileUtils.rm_rf(Dir["#{TIMETABLES_DIR}/*"])
    download = URI.open(TIMETABLES_URL)
    IO.copy_stream(download, "#{TIMETABLES_DIR}/#{TIMETABLES_ZIP}")
    river_zip_filename = unzip_file("#{TIMETABLES_DIR}/#{TIMETABLES_ZIP}", TIMETABLES_DIR, 'RIVER')
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
