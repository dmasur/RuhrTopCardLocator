require 'nokogiri'

##
# Parses one Offer from the website
class OfferParser
  CITY_REGEXP = /^\d{4}.*$/ # 4 because of the netherland postalcode
  STREET_REGEXP = /^[a-z\sßöäü:-]+([\d–\-]+\w?)?$/
  WEBSITE_REGEXP = /^www.*$/

  def initialize(content)
    @page = Nokogiri::HTML.parse content
  end

  def name
    clean_up_spaces @page.css('.claRight.claPrint h1').text
  end

  def description
    clean_up_spaces @page.css('.claRight.claPrint div p').map(&:text).find(&:present?)
  end

  def street
    address_part(STREET_REGEXP)
  end

  def city
    address_part(CITY_REGEXP)
  end

  def website
    address_part(WEBSITE_REGEXP)
  end

  def category
    @page.css('h2').first.text
  end

  def to_s
    puts name
    puts street
    puts city
    puts website
    puts category
    puts '-' * 20
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

  def clean_up_spaces(string)
    string.gsub("\n", ' ').gsub(/[[:space:]]+/,' ').strip if string.is_a? String
  end
end
