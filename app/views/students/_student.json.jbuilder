# frozen_string_literal: true

json.extract! student, :id, :firstName, :lastName, :email, :uin, :year, :major, :gpa, :status, :created_at, :updated_at
json.url student_url(student, format: :json)
