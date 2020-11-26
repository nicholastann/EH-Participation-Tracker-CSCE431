# frozen_string_literal: true

class Event < ApplicationRecord
  require 'csv'

  def self.import(file)
    CSV.foreach(file.path, headers: true) do |row|
      Event.create! row.to_hash
    end
  end

  def self.to_csv
    attributes = %w[name date description event_type location]

    CSV.generate(headers: true) do |csv|
      csv << attributes
      all.each do |event|
        csv << [event.name, event.date, event.description, event.event_type, event.location]
      end
    end
  end

  validates :name, presence: true
  validates :description, presence: true
  validates :date, presence: true
  validates :location, presence: true
  validates :event_type, presence: true

  validates :name, presence: true
  validates :description, presence: true
  validates :date, presence: true
  validates :location, presence: true
  validates :event_type, presence: true

  has_and_belongs_to_many :student, class_name: 'Student'
  accepts_nested_attributes_for :student

  has_and_belongs_to_many :user, through: :student
  accepts_nested_attributes_for :user
end
