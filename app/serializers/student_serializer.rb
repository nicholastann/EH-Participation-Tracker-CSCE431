# frozen_string_literal: true

class StudentSerializer
  include FastJsonapi::ObjectSerializer
  attributes :firstName, :lastName, :email, :uin, :year, :gpa, :major, :status
end
