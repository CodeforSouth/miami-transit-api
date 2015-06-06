class TrolleyController < ApplicationController
  def index
    vehicle_api = MiamiCityTransit.proxy(
      service: 'get_vehicles',
      'includeETAData' => 1,
      'orderedETAArray' => 1,
      token: 'TESTING'
    )
    routes_api = MiamiCityTransit.routes
    stops_api = MiamiCityTransit.stops

    @translator = TrolleyTranslator.new vehicles: vehicle_api.body, routes: routes_api.body, stops: stops_api.body

    respond_to do |format|
      format.json { render json: @translator.to_gtfs(encode: false) }
      format.gtfsrt { send_data @translator.to_gtfs }
    end
  end
end
