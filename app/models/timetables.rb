# Thames Clippers timetables data, retrieved from TFL's open data APIs
module Timetables
  extend self

  def pier_names
    Set.new(rb6_xml.xpath('TransXChange/StopPoints/StopPoint/Descriptor/CommonName')) do |name|
      enumize(name.text)
    end
  end

  private

  def enumize(name)
    name.parameterize(separator: '_').upcase
  end

  def rb6_xml
    @rb6_xml ||= RB6XML.new.parsed_xml
  end
end
