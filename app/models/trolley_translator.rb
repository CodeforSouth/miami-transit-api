require Rails.root.join 'lib', 'gtfs-realtime.pb.rb'

class TrolleyTranslator
  attr_accessor :vehicles_data, :routes_data, :stops_data

  def initialize(vehicles:, routes:, stops:)
    @vehicles_data = JSON.parse vehicles
    @routes_data   = JSON.parse routes
    @stops_data    = JSON.parse stops
  end

  def to_gtfs(encode: true)
    message.entity = vehicles_data['get_vehicles'].map do |veh|
      FeedEntity.new.tap do |entity|
        entity.id = "#{veh['equipmentID']}-#{veh['routeID']}"
        entity.is_deleted = false
        entity.vehicle = VehiclePosition.new.tap do |vp|
          vp.trip = TripDescriptor.new.tap do |trip|
            trip.route_id = veh['routeID']
          end
          vp.vehicle = VehicleDescriptor.new.tap do |vehicle|
            vehicle.id = veh['equipmentID']
          end
          vp.position = Position.new.tap do |pos|
            pos.latitude = veh['lat']
            pos.longitude = veh['lng']
          end
          vp.stop_id = veh['nextStopID']
          vp.timestamp = veh['receiveTime']
        end
      end
    end

    encode ? message.encode : message.to_hash
  end

  private

  def message
    @message ||= FeedMessage.new.tap do |msg|
      msg.header = header
    end
  end

  def header
    @header ||= FeedHeader.new.tap do |head|
      head.gtfs_realtime_version = '1.0'
    end
  end
end
