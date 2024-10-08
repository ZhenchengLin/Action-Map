# frozen_string_literal: true

Then /I should see Select Representative and Issue/ do
  expect(page).to have_content('Select Representative and Issue')
end

Then /I select a representative and issue/ do
  select 'Joseph R. Biden', from: 'representative_id'
  select 'Climate Change', from: 'issue_id'
end

And /I click on the search button/ do
  click_button('Search')
end

Then /I am at the new_page2/ do
  representative = Representative.find_by(name: 'Joseph R. Biden')
  expect(representative).not_to be_nil, 'Representative not found'
  expected_path = "/representatives/#{representative.id}/my_news_item/new_page2"
  expect(current_path).to eq(expected_path)
end
