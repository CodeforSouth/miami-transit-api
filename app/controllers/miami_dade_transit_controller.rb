class MiamiDadeTransitController < ApplicationController

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

    lat = params[:lat]
    long = params[:long]

    @nearby = MiamiDadeTransit.nearby(lat, long)

    respond_to do |format|
      if @nearby.response.code == '200'
        format.json { render json: @nearby, status: :ok }
        format.xml { render xml: @nearby.body, status: :ok }
      else
        format.json { render json: @nearby.response.code, status: :unprocessable_entity }
      end
    end

  end

end
