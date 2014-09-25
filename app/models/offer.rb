class Offer < ActiveRecord::Base
  include Surrounded

  geocoded_by :full_street_address   # can also be an IP address
  after_validation :geocode          # auto-fetch coordinates

  def full_street_address
    [street, city].compact.join(", ")
  end
end
