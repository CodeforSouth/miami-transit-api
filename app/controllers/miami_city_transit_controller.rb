class MiamiCityTransitController < ApplicationController

  def routes
    endpoint_params = params.except(:controller, :format, :action, :endpoint)

    @api = MiamiCityTransit.routes(endpoint_params)

    respond_to do |format|
      if @api.response.code == '200'
        format.json { render json: @api.to_json.encode(Encoding::UTF_8), status: :ok }
        format.xml { render xml: @api, status: :ok }
      else
        format.json { render json: @api.response.code, status: :unprocessable_entity }
      end
    end

  end

  def stops
    endpoint_params = params.except(:controller, :format, :action, :endpoint)

    @api = MiamiCityTransit.stops(endpoint_params)

    respond_to do |format|
      if @api.response.code == '200'
        format.json { render json: @api.to_json.encode(Encoding::UTF_8), status: :ok }
        format.xml { render xml: @api, status: :ok }
      else
        format.json { render json: @api.response.code, status: :unprocessable_entity }
      end
    end

  end

  def vehicles
    endpoint_params = params.except(:controller, :format, :action, :endpoint)

    @api = MiamiCityTransit.vehicles(endpoint_params)

    respond_to do |format|
      if @api.response.code == '200'
        format.json { render json: @api.to_json.encode(Encoding::UTF_8), status: :ok }
        format.xml { render xml: @api, status: :ok }
      else
        format.json { render json: @api.response.code, status: :unprocessable_entity }
      end
    end

  end

  def proxy
    endpoint_params = params.except(:controller, :format, :action, :endpoint)

    @api = MiamiCityTransit.proxy(endpoint_params)

    respond_to do |format|
      if @api.response.code == '200'
        format.json { render json: @api.to_json.encode(Encoding::UTF_8), status: :ok }
        format.xml { render xml: @api, status: :ok }
      else
        format.json { render json: @api.response.code, status: :unprocessable_entity }
      end
    end

  end

end
