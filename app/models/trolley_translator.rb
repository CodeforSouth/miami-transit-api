require Rails.root.join 'lib', 'gtfs-realtime.pb.rb'

class TrolleyTranslator
  attr_accessor :vehicles_data, :routes_data, :stops_data

  def initialize(vehicles:, routes:, stops:)
    @vehicles_data = vehicles
    @routes_data   = routes
    @stops_data    = stops
  end

  def to_gtfs(encode: true)
    message.entity = vehicles_data.map do |veh|
      FeedEntity.new.tap do |entity|
        entity.id = "#{veh['equipmentID']}-#{veh['routeID']}"
        entity.is_deleted = false

        entity.trip_update = TripUpdate.new.tap do |tu|
          tu.trip = TripDescriptor.new.tap do |trip|
            trip.route_id = veh['routeID'].to_s
            trip.trip_id = veh['routeID'].to_s
            trip.schedule_relationship = TripDescriptor::ScheduleRelationship::UNSCHEDULED
          end
          tu.stop_time_update = get_stop_time_update(veh)
        end

        entity.vehicle = VehiclePosition.new.tap do |vp|
          vp.trip = TripDescriptor.new.tap do |trip|
            trip.route_id = veh['routeID'].to_s
            trip.trip_id = veh['routeID'].to_s
            trip.schedule_relationship = TripDescriptor::ScheduleRelationship::UNSCHEDULED
          end
          vp.vehicle = VehicleDescriptor.new.tap do |vehicle|
            vehicle.id = veh['equipmentID']
          end
          vp.position = Position.new.tap do |pos|
            pos.latitude = veh['lat']
            pos.longitude = veh['lng']
          end
          vp.stop_id = veh['nextStopID'].to_s
          vp.timestamp = veh['receiveTime']
        end
      end
    end

    encode ? message.encode : message.to_hash
  end

  private

  def get_stop_time_update(veh)
    route = get_route(veh['routeID'])
    current_time = Time.at(veh['receiveTime']/1000)
    veh['minutesToNextStops'].map do |next_stop|
      stop_sequence = route['stops'].map(&:to_s).index(next_stop['stopID'].to_s)
      arrival_time =  current_time + next_stop['minutes'].minutes
      TripUpdate::StopTimeUpdate.new.tap do |stu|
        stu.stop_sequence = stop_sequence
        stu.stop_id = next_stop['stopID']
        stu.arrival = TripUpdate::StopTimeEvent.new.tap do |ste|
          ste.time = arrival_time.to_i
        end
      end
    end
  end

  def get_route(route_id)
    routes_data.find { |route| route['id'].to_s == route_id.to_s }
  end

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
