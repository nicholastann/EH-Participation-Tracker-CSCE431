# frozen_string_literal: true

class CreateStudents < ActiveRecord::Migration[5.1]
  def change
    create_table :students do |t|
      t.string :firstName
      t.string :lastName
      t.string :email
      t.integer :uin
      t.integer :year
      t.string :major
      t.float :gpa
      t.string :status

      t.timestamps
    end
  end
end
