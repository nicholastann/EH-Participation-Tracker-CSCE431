# frozen_string_literal: true

class Student < ApplicationRecord
  require 'csv'

  def self.import(file)
    CSV.foreach(file.path, headers: true) do |row|
      Student.create! row.to_hash
    end
  end

  def self.to_csv
    attributes = %w[firstName lastName email uin year major gpa status]

    CSV.generate(headers: true) do |csv|
      csv << attributes
      all.each do |student|
        csv << [student.firstName, student.lastName, student.email, student.uin, student.year, student.major, student.gpa, student.status]
      end
    end
  end

  def self.to_csv2(options = {})
    desired_columns = ["First Name", "Last Name", "Email", "UIN", "Events"]
    CSV.generate(options) do |csv|
      # header columns
      csv << desired_columns
      # data columns
      all.each do |student|
        events = ""
        student.event.each do |event|
          events+= event.name 
          events+= "\n"
        end
        csv << [student.firstName, student.lastName, student.email, student.uin, events]
      end
    end
  end 

  has_one :user, class_name: 'User'
  accepts_nested_attributes_for :user

  has_and_belongs_to_many :event, class_name: 'Event'
  accepts_nested_attributes_for :event

  validates :firstName, presence: true
  validates :lastName, presence: true
  validates :email, presence: true
  validates :uin, presence: true
  validates :year, presence: true
  validates :major, presence: true
  validates :gpa, presence: true
  validates :status, presence: true

  validates_uniqueness_of :email
  validates_uniqueness_of :uin

  STANDING_LIST = ['Good Standing', 'Bad Standing'].freeze
end
