# frozen_string_literal: true

class Representative < ApplicationRecord
  has_many :news_items, dependent: :delete_all

  def self.civic_api_to_representative_params(rep_info)
    rep_info.officials.each_with_index.map do |official, index|
      solve_representative_from_official(official, index, rep_info.offices)
    end
  end

  def self.solve_representative_from_official(official, index, offices)
    office = find_office_for_official(index, offices)
    rep_info = {
      name:            official.name,
      ocdid:           office&.division_id || '',
      title:           office&.name || '',
      contact_address: format_contact_address(official.address),
      political_party: official.party || '',
      photo_url:       official.photo_url || ''
    }
    begin
      rep = find_representative_from_db_and_update(rep_info)
    rescue ActiveRecord::RecordNotFound
      rep = create_representative_in_db(rep_info)
    end
    rep
  end

  def self.find_representative_from_db_and_update(info)
    rep = find_by!(name: info[:name])
    rep.update(info)
    rep.save
    rep
  end

  def self.create_representative_in_db(info)
    create!(info)
  end

  def self.find_office_for_official(index, offices)
    offices.find { |office| office.official_indices.include?(index) }
  end

  def self.format_contact_address(addresses)
    return '' unless addresses

    addresses.map { |addr| "#{addr.line1}, #{addr.city}, #{addr.state} #{addr.zip}" }.join("\n")
  end
end
