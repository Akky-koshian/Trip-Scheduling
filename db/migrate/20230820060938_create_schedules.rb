class CreateSchedules < ActiveRecord::Migration[6.1]
  def change
    create_table :schedules do |t|
      t.references :user
      t.string :date
      t.timestamps null: false
    end
  end
end