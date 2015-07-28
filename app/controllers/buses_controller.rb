class BusesController < ApplicationController
  def index
    bus_xml = MiamiDadeTransit.buses.body
    translator = MiamiDadeBusTranslator.new bus_xml

    respond_to do |format|
      format.json { render json: translator.to_hash.to_json }
      format.gtfsrt { send_data translator.to_gtfs }
    end
  end
end
