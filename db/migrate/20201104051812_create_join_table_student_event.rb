# frozen_string_literal: true

class CreateJoinTableStudentEvent < ActiveRecord::Migration[5.1]
  def change
    create_join_table :students, :events do |t|
      # t.index [:student_id, :event_id]
      # t.index [:event_id, :student_id]
    end
  end
end
