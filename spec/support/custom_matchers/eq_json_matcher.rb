RSpec::Matchers.define :eq_json do |expected|
  expected_status_code = 200
  match do |actual|
    response_body = JSON.parse(actual.body)
    (response_body == expected) && (actual.status == expected_status_code)
  end
  failure_message do |actual|
    "expected that #{actual.body} would equal #{expected}
     and that status code #{actual.status} would equal #{expected_status_code}"
  end
end
