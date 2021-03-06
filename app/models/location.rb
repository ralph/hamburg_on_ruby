class Location < ActiveRecord::Base

  acts_as_api

  api_accessible :ios_v1 do |template|
    template.add :id
    template.add :name
    template.add :url
    template.add :city
    template.add :street
    template.add :house_number
    template.add :zip
  end

  geocoded_by :full_address, latitude: :lat, longitude: :long
  after_validation :geocode unless Rails.env.test? # TODO (ps) disable geocoder somehow

  has_many :events

  validates :name, :url, :city, :street, :house_number, :zip, :presence => true

  scope :company, where(company: true)
  scope :cometogether, joins(:events).select("distinct(locations.id), locations.*")

  def full_address
    "#{street} #{house_number}, #{zip} #{city}, Deutschland"
  end

end
