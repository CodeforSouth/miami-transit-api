require Rails.root.join 'lib', 'gtfs-realtime.pb.rb'

class TrolleyTranslator
  def initialize(json)
    @json = json
  end

  def to_gtfs
    message.entity = data['get_vehicles'].map do |veh|
      FeedEntity.new.tap do |entity|
        entity.id = SecureRandom.uuid
        entity.is_deleted = false
        entity.vehicle = VehiclePosition.new.tap do |vp|
          vp.position = Position.new.tap do |pos|
            pos.latitude = veh['lat']
            pos.longitude = veh['lng']
          end
        end
      end
    end

    message.encode
  end

  private
  def data
    @data ||= JSON.parse @json
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
