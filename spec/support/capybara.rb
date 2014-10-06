require 'capybara/rspec'
require 'capybara/poltergeist'
require 'capybara-screenshot/rspec'
Capybara.register_driver :poltergeist do |app|
  Capybara::Poltergeist::Driver.new(
    app,
    extensions: [
      File.expand_path('../spec/support/phantomjs_ext/geolocation.js', __FILE__)
    ]
  )
end
Capybara.default_driver = :poltergeist
include Capybara::Angular::DSL
