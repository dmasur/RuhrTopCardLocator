require 'vcr'

VCR.configure do |c|
  c.cassette_library_dir = Rails.root.join 'spec', 'vcr'
  c.hook_into :webmock
  c.ignore_localhost = true
  c.ignore_hosts 'codeclimate.com'
  c.configure_rspec_metadata!
end
