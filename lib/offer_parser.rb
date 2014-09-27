require 'nokogiri'

##
# Parses one Offer from the website
class OfferParser
  CITY_REGEXP = /^\d{4}.*$/ # 4 because of the netherland postalcode
  STREET_REGEXP = /^[a-z\sßöäü:-]+([\d–\-]+\w?)?$/
  WEBSITE_REGEXP = /^www.*$/

  ##
  # Init nokogiri
  # @param [String, #content] content of the website
  def initialize(content)
    @page = Nokogiri::HTML.parse content
  end

  ##
  # Name of the Offer
  def name
    clean_up_spaces @page.css('.claRight.claPrint h1').text
  end

  ##
  # Description text
  def description
    clean_up_spaces @page.css('.claRight.claPrint div p').map(&:text).find(&:present?)
  end

  ##
  # Street
  def street
    address_part(STREET_REGEXP)
  end

  ##
  # City
  def city
    address_part(CITY_REGEXP)
  end

  ##
  # Website
  def website
    address_part(WEBSITE_REGEXP)
  end

  ##
  # Category
  def category
    @page.css('h2').first.text
  end

  private

  ##
  # Shortcut to find part that matches the regexp
  def address_part(reg_exp, string=address_parts)
    string.find { |line| reg_exp.match line.downcase }
  end

  ##
  # Select the line with the city in it
  def address_parts
    texts = @page.css('.claAngebot .claRight p').map(&:text)
    found_address = address_part(CITY_REGEXP, texts) || address_part(WEBSITE_REGEXP, texts) || ''
    found_address.split("\n").map { |line| clean_up_spaces(line) }
  end

  ##
  # Clean line brakes, unbreakable and normal spaces
  def clean_up_spaces(string)
    string.gsub("\n", ' ').gsub(/[[:space:]]+/, ' ').strip if string.is_a? String
  end
end
