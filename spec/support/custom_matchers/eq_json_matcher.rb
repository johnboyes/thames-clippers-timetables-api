RSpec::Matchers.define :eq_json do |expected|
  expected_status_code = 200
  match do |actual|
    response_body = JSON.parse(actual.body)
    (response_body == expected) && (actual.status == expected_status_code)
  end
  failure_message do |actual|
    "expected that #{pretty(JSON.parse(actual.body))} would equal #{pretty(expected)}
     and that status code #{actual.status} would equal #{expected_status_code}"
  end
end

def pretty(json)
  JSON.pretty_generate(json)
end
