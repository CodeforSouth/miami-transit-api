class MiamiDadeTransitController < ApplicationController
  before_action 'normalize_params!', :except => :proxy

  def buses
    @buses = MiamiDadeTransit.buses

    respond_to do |format|
      if @buses.response.code == '200'
        format.json { render json: @buses, status: :ok }
        format.xml { render xml: @buses.body, status: :ok }
      else
        format.json { render json: @buses.response.code, status: :unprocessable_entity }
      end
    end

  end

  def bus
    @bus = MiamiDadeTransit.bus(params[:id])
    respond_to do |format|
      if @bus.response.code == '200'
        format.json { render json: @bus, status: :ok }
        format.xml { render xml: @bus.body, status: :ok }
      else
        format.json { render json: @bus.response.code, status: :unprocessable_entity }
      end
    end
  end

  def nearby

    @nearby = MiamiDadeTransit.nearby(params)

    respond_to do |format|
      if @nearby.response.code == '200'
        format.json { render json: @nearby, status: :ok }
        format.xml { render xml: @nearby.body, status: :ok }
      else
        format.json { render json: @nearby.response.code, status: :unprocessable_entity }
      end
    end

  end

  def proxy

    endpoint = params[:endpoint]
    endpoint_params = params.except(:controller, :format, :action, :endpoint)

    @api = MiamiDadeTransit.proxy(endpoint, endpoint_params)

    respond_to do |format|
      if @api.response.code == '200'
        format.json { render json: @api, status: :ok }
        format.xml { render xml: @api.body, status: :ok }
      else
        format.json { render json: @api.response.code, status: :unprocessable_entity }
      end
    end

  end

end
