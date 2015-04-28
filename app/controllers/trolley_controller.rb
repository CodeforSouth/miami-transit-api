class TrolleyController < ApplicationController
  def index
    @api = MiamiCityTransit.proxy(
      service: 'get_vehicles',
      'includeETAData' => 1,
      'orderedETAArray' => 1,
      token: 'TESTING'
    )

    respond_to do |format|
      format.json { render text: @api.body }
      format.gtfsrt do
        translator = TrolleyTranslator.new @api.body
        send_data translator.to_gtfs
      end
    end
  end
end
