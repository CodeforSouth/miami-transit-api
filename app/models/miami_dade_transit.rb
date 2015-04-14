class MiamiDadeTransit
  require 'httparty'
  include HTTParty

  base_uri 'http://www.miamidade.gov/transit/WebServices/'

  # get all buses
  def self.buses
    endpoint = '/buses'
    self.get(endpoint)
  end

  # get a bus by id
  def self.bus(id)
    endpoint = '/buses/?busid=' + id
    self.get(endpoint)
  end

  # POIs
  # Nearby/?Lat=25.787057&Long=-80.189107
  def self.nearby(lat, long)
    endpoint = '/nearby/'
    params = {
        Lat: lat.to_f,
        Long: long.to_f}
    self.get(endpoint, :query => params)
  end

end