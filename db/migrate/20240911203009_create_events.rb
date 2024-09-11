class CreateEvents < ActiveRecord::Migration[7.1]
  def change
    create_table :events do |t|
      t.string :venue_name
      t.string :event_name
      t.datetime :date_time
      t.string :artist
      t.string :location

      t.timestamps
    end
  end
end
