class AddTimeAndSoOnToSchedule < ActiveRecord::Migration[6.1]
  def change
    add_column :schedules, :time, :time
    add_column :schedules, :place, :text
    add_column :schedules, :schedule, :text
    add_column :schedules, :note, :text
  end
end
