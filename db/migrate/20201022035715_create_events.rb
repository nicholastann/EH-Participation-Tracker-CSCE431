# frozen_string_literal: true

class CreateEvents < ActiveRecord::Migration[5.1]
  def change
    create_table :events do |t|
      t.string :name
      t.timestamp :date
      t.text :description
      t.string :event_type
      t.string :location

      t.timestamps
    end
  end
end
