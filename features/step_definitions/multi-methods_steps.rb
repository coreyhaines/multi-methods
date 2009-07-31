Given /^the following code$/ do |code|
  eval code
end

When /^I run$/ do |code|
  @result = eval code
end

Then /^the return should be "([^\"]*)"$/ do |expected_result|
  @result.to_s.should == expected_result
end
