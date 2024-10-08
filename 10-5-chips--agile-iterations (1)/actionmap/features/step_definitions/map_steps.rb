# frozen_string_literal: true

When /I click on the state "(.*)"/ do |abr|
  visit "state/#{abr}"
end

When /I click the county titled "(.*)"/ do |county_name|
  address = "search/#{Addressable::URI.encode_component(county_name, Addressable::URI::CharacterClasses::UNRESERVED)}"
  visit address
end

Then /^I am (not )?visiting the "(.+)" state page$/ do |no, state_name|
  if no
    expect(page).not_to have_content(state_name)
  else
    expect(page).to have_content(state_name)
  end
end

Then /^I am (not )?viewing the "(.+)" representatives page$/ do |no, county_name|
  if no
    expect(page).not_to have_content(county_name)
  else
    expect(page).to have_content(county_name)
  end
end

Then /^I should (not )?see the following representatives: (.*)$/ do |no, rep_list|
  rep_list.split(',').each do |field|
    if no
      expect(page).not_to have_content(field)
    else
      expect(page).to have_content(field)
    end
  end
end

Then /I should see representative "(.*)" before "(.*)"/ do |e1, e2|
  expect(page.body.index(e1) < page.body.index(e2))
end
