# frozen_string_literal: true

class AddIssueToNewsItem < ActiveRecord::Migration[5.2]
  def change
    add_column :news_items, :issue_id, :integer
    change_column :news_items, :issue_id, :integer, null: false
  end
end
