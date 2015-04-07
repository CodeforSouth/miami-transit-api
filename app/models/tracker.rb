class Tracker
  require 'httparty'
  include HTTParty

  base_uri 'https://198.74.52.26/map/map-json.php'
  default_options.update(verify: false)

  def self.live
    endpoint = ''
    self.get(endpoint)
  end

end