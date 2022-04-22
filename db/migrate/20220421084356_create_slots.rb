class CreateSlots < ActiveRecord::Migration[6.0]
  def change
    create_table :slots do |t|
      t.timestamp :start_time
      t.timestamp :end_time
      t.timestamps
    end
  end
end
