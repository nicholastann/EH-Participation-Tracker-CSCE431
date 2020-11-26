# frozen_string_literal: true

json.extract! event, :name, :date, :description, :eventID, :type, :service, :created_at, :updated_at
json.url student_url(event, format: :json)
