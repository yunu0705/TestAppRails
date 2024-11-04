class CreateSchedules < ActiveRecord::Migration[7.1]
  def change
    create_table :schedules do |t|
      t.integer :user_id
      t.string :day_of_week
      t.string :time_range
      t.text :description

      t.timestamps
    end
  end
end
