Geocoder.configure(lookup: :test)

Geocoder::Lookup::Test.add_stub(
  'Burgstraße 70, 45476 Mülheim an der Ruhr', [
    {
      'latitude'     => 51.4430897,
      'longitude'    => 6.8559475,
      'state_code'   => 'NRW',
      'country'      => 'Germany',
      'country_code' => 'DE'
    }
  ]
)
