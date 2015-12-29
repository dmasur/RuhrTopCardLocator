require 'nokogiri'

##
# Parses one Offer from the website
class OfferParser
  CITY_REGEXP = /^\d{4}.*$/ # 4 because of the netherland postalcode
  STREET_REGEXP = /^[\/A-Za-z\söäßü:-]+([\d–\-]+\w?)?$/
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
    clean_up_spaces @page.css('h1').text
  end

  ##
  # Description text
  def description
    clean_up_spaces @page.css('.description').text
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

  def kind
    if @page.css('.icon-half').present?
      return "half-price"
    end
  end

  ##
  # Category
  def category
    @page.css('.category').first.text
  end

  private

  ##
  # Shortcut to find part that matches the regexp
  def address_part(reg_exp, string = address_parts)
    string.find { |line| reg_exp.match line.downcase }
  end

  ##
  # Select the line with the city in it
  def address_parts
    @page.css('.address').first.text.split("\n").map { |line| clean_up_navigation(line) }.map { |line| clean_up_spaces(line) }
  end

  ##
  # Clean line brakes, unbreakable and normal spaces
  def clean_up_spaces(string)
    string.gsub("\n", ' ').gsub(/[[:space:]]+/, ' ').strip if string.is_a? String
  end

  ##
  # Clean navigation comments
  def clean_up_navigation(string)
    if string.is_a? String
      string.gsub!(/Navigation:.*$/, '')
      string.gsub!(/Verwaltung:.*$/, '')
      string.gsub!(/Haupteingang: /, '')
      string.gsub!(/Spielstätte: /, '')
      string.gsub!(/Büro: [^,]*, /, '')
      string.gsub!(/Kontakt/, '')
      return string
    end
  end
end
