## Generated from vendor/gtfs-realtime.proto for transit_realtime
require "beefcake"


class FeedMessage
  include Beefcake::Message
end

class FeedHeader
  include Beefcake::Message

  module Incrementality
    FULL_DATASET = 0
    DIFFERENTIAL = 1
  end
end

class FeedEntity
  include Beefcake::Message
end

class TripUpdate
  include Beefcake::Message

  class StopTimeEvent
    include Beefcake::Message
  end

  class StopTimeUpdate
    include Beefcake::Message

    module ScheduleRelationship
      SCHEDULED = 0
      SKIPPED = 1
      NO_DATA = 2
    end
  end
end

class VehiclePosition
  include Beefcake::Message

  module VehicleStopStatus
    INCOMING_AT = 0
    STOPPED_AT = 1
    IN_TRANSIT_TO = 2
  end

  module CongestionLevel
    UNKNOWN_CONGESTION_LEVEL = 0
    RUNNING_SMOOTHLY = 1
    STOP_AND_GO = 2
    CONGESTION = 3
    SEVERE_CONGESTION = 4
  end

  module OccupancyStatus
    EMPTY = 0
    MANY_SEATS_AVAILABLE = 1
    FEW_SEATS_AVAILABLE = 2
    STANDING_ROOM_ONLY = 3
    CRUSHED_STANDING_ROOM_ONLY = 4
    FULL = 5
    NOT_ACCEPTING_PASSENGERS = 6
  end
end

class Alert
  include Beefcake::Message

  module Cause
    UNKNOWN_CAUSE = 1
    OTHER_CAUSE = 2
    TECHNICAL_PROBLEM = 3
    STRIKE = 4
    DEMONSTRATION = 5
    ACCIDENT = 6
    HOLIDAY = 7
    WEATHER = 8
    MAINTENANCE = 9
    CONSTRUCTION = 10
    POLICE_ACTIVITY = 11
    MEDICAL_EMERGENCY = 12
  end

  module Effect
    NO_SERVICE = 1
    REDUCED_SERVICE = 2
    SIGNIFICANT_DELAYS = 3
    DETOUR = 4
    ADDITIONAL_SERVICE = 5
    MODIFIED_SERVICE = 6
    OTHER_EFFECT = 7
    UNKNOWN_EFFECT = 8
    STOP_MOVED = 9
  end
end

class TimeRange
  include Beefcake::Message
end

class Position
  include Beefcake::Message
end

class TripDescriptor
  include Beefcake::Message

  module ScheduleRelationship
    SCHEDULED = 0
    ADDED = 1
    UNSCHEDULED = 2
    CANCELED = 3
  end
end

class VehicleDescriptor
  include Beefcake::Message
end

class EntitySelector
  include Beefcake::Message
end

class TranslatedString
  include Beefcake::Message

  class Translation
    include Beefcake::Message
  end
end

class FeedMessage
  required :header, FeedHeader, 1
  repeated :entity, FeedEntity, 2
end

class FeedHeader
  required :gtfs_realtime_version, :string, 1
  optional :incrementality, FeedHeader::Incrementality, 2, :default => FeedHeader::Incrementality::FULL_DATASET
  optional :timestamp, :uint64, 3
end

class FeedEntity
  required :id, :string, 1
  optional :is_deleted, :bool, 2, :default => false
  optional :trip_update, TripUpdate, 3
  optional :vehicle, VehiclePosition, 4
  optional :alert, Alert, 5
end

class TripUpdate

  class StopTimeEvent
    optional :delay, :int32, 1
    optional :time, :int64, 2
    optional :uncertainty, :int32, 3
  end

  class StopTimeUpdate
    optional :stop_sequence, :uint32, 1
    optional :stop_id, :string, 4
    optional :arrival, TripUpdate::StopTimeEvent, 2
    optional :departure, TripUpdate::StopTimeEvent, 3
    optional :schedule_relationship, TripUpdate::StopTimeUpdate::ScheduleRelationship, 5, :default => TripUpdate::StopTimeUpdate::ScheduleRelationship::SCHEDULED
  end
  required :trip, TripDescriptor, 1
  optional :vehicle, VehicleDescriptor, 3
  repeated :stop_time_update, TripUpdate::StopTimeUpdate, 2
  optional :timestamp, :uint64, 4
  optional :delay, :int32, 5
end

class VehiclePosition
  optional :trip, TripDescriptor, 1
  optional :vehicle, VehicleDescriptor, 8
  optional :position, Position, 2
  optional :current_stop_sequence, :uint32, 3
  optional :stop_id, :string, 7
  optional :current_status, VehiclePosition::VehicleStopStatus, 4, :default => VehiclePosition::VehicleStopStatus::IN_TRANSIT_TO
  optional :timestamp, :uint64, 5
  optional :congestion_level, VehiclePosition::CongestionLevel, 6
  optional :occupancy_status, VehiclePosition::OccupancyStatus, 9
end

class Alert
  repeated :active_period, TimeRange, 1
  repeated :informed_entity, EntitySelector, 5
  optional :cause, Alert::Cause, 6, :default => Alert::Cause::UNKNOWN_CAUSE
  optional :effect, Alert::Effect, 7, :default => Alert::Effect::UNKNOWN_EFFECT
  optional :url, TranslatedString, 8
  optional :header_text, TranslatedString, 10
  optional :description_text, TranslatedString, 11
end

class TimeRange
  optional :start, :uint64, 1
  optional :end, :uint64, 2
end

class Position
  required :latitude, :float, 1
  required :longitude, :float, 2
  optional :bearing, :float, 3
  optional :odometer, :double, 4
  optional :speed, :float, 5
end

class TripDescriptor
  optional :trip_id, :string, 1
  optional :route_id, :string, 5
  optional :direction_id, :uint32, 6
  optional :start_time, :string, 2
  optional :start_date, :string, 3
  optional :schedule_relationship, TripDescriptor::ScheduleRelationship, 4
end

class VehicleDescriptor
  optional :id, :string, 1
  optional :label, :string, 2
  optional :license_plate, :string, 3
end

class EntitySelector
  optional :agency_id, :string, 1
  optional :route_id, :string, 2
  optional :route_type, :int32, 3
  optional :trip, TripDescriptor, 4
  optional :stop_id, :string, 5
end

class TranslatedString

  class Translation
    required :text, :string, 1
    optional :language, :string, 2
  end
  repeated :translation, TranslatedString::Translation, 1
end
