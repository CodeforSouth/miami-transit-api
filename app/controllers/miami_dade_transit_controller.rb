class MiamiDadeTransitController < ApplicationController
  require 'json'

  def buses
    @buses = MiamiDadeTransit.buses

    respond_to do |format|
      if @buses.response.code == '200'
        format.json { render json: @buses, status: :ok }
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
      else
        format.json { render json: @bus.response.code, status: :unprocessable_entity }
      end
    end
  end

end
