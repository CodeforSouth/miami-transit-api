class TrackerController < ApplicationController
  require 'json'

  def live
    @tracker = Tracker.live

    respond_to do |format|
      if @tracker.response.code == '200'
        format.json { render json: @tracker, status: :ok }
        format.xml { render xml: @tracker.body, status: :ok }
      else
        format.json { render json: @tracker.response.code, status: :unprocessable_entity }
      end
    end

  end

end
