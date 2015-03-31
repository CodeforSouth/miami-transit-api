class MiamiDadeTransit
  require 'httparty'
  include HTTParty

  base_uri 'http://www.miamidade.gov/transit/WebServices/'

  def self.buses
    endpoint = '/buses'
    self.get(endpoint)
  end

  def self.bus(id)
    endpoint = '/buses/?busid=' + id
    self.get(endpoint)
  end

end