# frozen_string_literal: true

class AddStudentRefToUser < ActiveRecord::Migration[5.1]
  def change
    add_reference :students, :user, foreign_key: true
  end
end
