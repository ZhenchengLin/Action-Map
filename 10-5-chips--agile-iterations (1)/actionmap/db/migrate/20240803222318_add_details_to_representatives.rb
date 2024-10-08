# frozen_string_literal: true

class AddDetailsToRepresentatives < ActiveRecord::Migration[5.2]
  def change
    add_column :representatives, :contact_address, :text
    add_column :representatives, :political_party, :string
    add_column :representatives, :photo_url, :string
  end
end
