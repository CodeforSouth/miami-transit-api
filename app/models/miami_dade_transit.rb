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

end