class MiamiDadeTransit
  require 'httparty'
  include HTTParty

  base_uri 'http://www.miamidade.gov/transit/WebServices/'

  # get all buses
  def self.buses(params={})
    endpoint = '/buses'
    options = {
      BusID: params[:busid],
      BusName: params[:busname],
      RouteID: params[:routeid],
      Dir: params[:dir]
    }
    self.get(endpoint, options)
  end

  # get a bus by id
  def self.bus(id)
    endpoint = '/buses/?busid=' + id
    self.get(endpoint)
  end

  # POIs
  # Nearby/?Lat=25.787057&Long=-80.189107
  def self.nearby(params)
    endpoint = '/nearby/'

    options = {
      Lat: params[:lat],
      Long: params[:long],
      Type: params[:type],
    }

    self.get(endpoint, :query => options)
  end

  def self.proxy(route, params)
    endpoint = "#{'/' + route +'/'}"
    self.get(endpoint, :query => params)
  end

end