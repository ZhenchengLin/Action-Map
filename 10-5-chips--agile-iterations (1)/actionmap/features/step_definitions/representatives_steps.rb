# frozen_string_literal: true

# features/step_definitions/representatives_steps.rb

Given /^(?:|I )am at the actionmap home page$/ do
  visit root_path
end

Then /^(?:|I )should see '([^']*)'$/ do |text|
  expect(page).to have_content(text)
end

When /^(?:|I )press the "([^"]*)" button$/ do |button|
  click_button(button)
end

When /^(?:|I )click on the "([^"]*)" link$/ do |link|
  click_link(link)
end

When /^(?:|I )type in '([^']*)'$/ do |location|
  fill_in 'address', with: location
  click_button 'Search'
end

Then /^(?:|I )should see "([^"]*)" before "([^"]*)"$/ do |text1, text2|
  expect(page.body.index(text1)).to be < page.body.index(text2)
end

When /^(?:|I )press the "([^"]*)" button for "([^"]*)"$/ do |_button, name|
  representative = Representative.find_by(name: name)
  visit representative_path(representative)
end
