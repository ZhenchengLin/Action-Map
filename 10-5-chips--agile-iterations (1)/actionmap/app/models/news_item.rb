# frozen_string_literal: true

class NewsItem < ApplicationRecord
  belongs_to :representative
  # has_many :ratings, dependent: :delete_all
  @issue_list = ['Free Speech', 'Immigration', 'Terrorism', "Social Security and
  Medicare", 'Abortion', 'Student Loans', 'Gun Control', 'Unemployment',
                 'Climate Change', 'Homelessness', 'Racism', 'Tax Reform', "Net
  Neutrality", 'Religious Freedom', 'Border Security', 'Minimum Wage',
                 'Equal Pay']

  def self.find_for(representative_id)
    NewsItem.find_by(
      representative_id: representative_id
    )
  end

  def self.issue_name(issue_id)
    @issue_list[issue_id]
  end

  def self.issue_list
    @issue_list.map.with_index { |i, index| [i, index] }
  end
end
