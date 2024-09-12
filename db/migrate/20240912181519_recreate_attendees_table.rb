class RecreateAttendeesTable < ActiveRecord::Migration[7.1]
  def change
    drop_table :user_events, if_exists: true

    create_table :attendees do |t|
      t.bigint :user_id, null: false
      t.bigint :event_id, null: false
      t.datetime :created_at, null: false
      t.datetime :updated_at, null: false

      t.index :event_id
      t.index :user_id
    end

    add_foreign_key :attendees, :users
    add_foreign_key :attendees, :events
  end
end
