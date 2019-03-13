RSpec::Matchers.define :eq_json do |expected|
  match do |response|
    response_body = JSON.parse(response.body)
    (response_body == expected) && (response.status == 200)
  end
end
