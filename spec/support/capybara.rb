require 'capybara/rspec'
require 'capybara/poltergeist'
require 'capybara-screenshot/rspec'
Capybara.default_driver = :poltergeist
include Capybara::Angular::DSL