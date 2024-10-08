# frozen_string_literal: true

# rubocop:disable Layout/LineLength
test_data = [
  {
    name:       'Gavin Newsom',
    news_items: [
      {
        title:       'Newsom Orders Second Shutdown of Restaurants and Indoor Businesses amid COVID-19',
        description: 'The new order affects 19 California counties with a surging number of coronavirus cases',
        link:        'https://people.com/human-interest/california-gov-gavin-newsom-orders-second-shutdown-of-restaurants-and-indoor-businesses-amid-covid-19/',
        issue_id:    3
      },
      {
        title:       "Newsom warns that young adults are not 'invincible' to Coronavirus",
        description: 'Gov. Gavin Newsom said Monday that the surge in coronavirus cases hitting California was due in part to younger people who might believe “they are invincible” but nonetheless are becoming sick from COVID-19.',
        link:        'https://www.latimes.com/california/story/2020-07-06/young-adult-who-think-they-are-invincible-hit-hard-by-coronavirus-newsom-says',
        issue_id:    3
      }
    ]
  },
  {
    name:       'Alexander Ocasio Cortez',
    news_items: [
      {
        title:       'What AOC and other House Dems want to do about Climate Change',
        description: 'A new select committee report is perfectly in tune with the growing climate policy alignment on the left around standards, investments, and justice.',
        link:        'https://www.vox.com/energy-and-environment/2020/6/30/21305891/aoc-climate-change-house-democrats-select-committee-report',
        issue_id:    8
      },
      {
        title:       'AOC among Dems who launch a fundraising campaign on a progressive platform',
        description: 'Democratic Reps. Alexandria Ocasio-Cortez of New York, Ilhan Omar of Minnesota, Rashida Tlaib of Michigan and Ayanna Pressley of Massachusetts are launching a joint fundraising committee called the "Squad Victory Fund," the latest effort by the well-known freshmen lawmakers to support one another and their advocacy for progressive priorities.',
        link:        'https://www.cnn.com/2020/07/01/politics/squad-ocasio-cortez-tlaib-omar-pressley/index.html',
        issue_id:    11
      },
      {
        title:       'AOC opts to skip debate citing social distancing rules',
        description: 'New York Rep. Alexandria Ocasio-Cortez insisted Monday she’s “not skipping debates” like her predecessor, Joe Crowley, did to disastrous effect two years ago — even though she is ducking one Wednesday citing social distancing rules despite having been out at a George Floyd protest and other group events this month.',
        link:        'https://nypost.com/2020/06/15/aoc-defends-decision-not-to-attend-wednesdays-debate-in-person/',
        issue_id:    3
      }
    ]
  }
]
# rubocop:enable Layout/LineLength

Given /^(?:|I )have some data in my database$/ do
  test_data.each do |rep|
    rep_model = Representative.create(name: rep[:name])
    rep[:news_items].each do |news_item|
      NewsItem.create(
        representative: rep_model,
        title:          news_item[:title],
        description:    news_item[:description],
        link:           news_item[:link],
        issue_id:       news_item[:issue_id]
      )
    end
  end
end

Then /^(?:|I )should be at the actionmap home page$/ do
  current_path = URI.parse(current_url).path
  expect(current_path).to eq(root_path)
end

When /^(?:|I )press "News Articles" button of "([^"]*)"$/ do |name|
  representative = Representative.find_by(name: name)
  visit representative_news_items_path(representative)
end

When /^(?:|I )press on a Info button$/ do
  find('a.btn-info', class: '!mx-1').click
end

When /^(?:|I )press on "([^"]*)"$/ do |tag|
  all('a', text: tag)[0].click
end
