# frozen_string_literal: true

class EventSerializer
  include FastJsonapi::ObjectSerializer
  attributes :name, :date, :description, :type, :eventID, :service
end
