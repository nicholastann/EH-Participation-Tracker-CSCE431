# frozen_string_literal: true

class User < ApplicationRecord
  has_secure_password
  validates_uniqueness_of :email
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }

  enum role: %i[member admin]

  has_one :student, class_name: 'Student'
  accepts_nested_attributes_for :student

  has_and_belongs_to_many :event, through: :student
  accepts_nested_attributes_for :event

  after_initialize do
    self.role ||= :member if new_record?
  end
end
