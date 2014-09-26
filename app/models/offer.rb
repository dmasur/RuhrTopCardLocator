##
# Offer that is parsed from the website
class Offer < ActiveRecord::Base

  geocoded_by :full_street_address   # can also be an IP address
  after_validation :geocode          # auto-fetch coordinates

  def full_street_address
    [street, city].compact.join(', ')
  end
end
