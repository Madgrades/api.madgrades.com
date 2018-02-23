class CreateSchedules < ActiveRecord::Migration[5.1]
  def change
    create_table :schedules, primary_key: :uuid, id: false do |t|
      t.string :uuid
      t.integer :start_time
      t.integer :end_time
      t.boolean :mon
      t.boolean :tues
      t.boolean :wed
      t.boolean :thurs
      t.boolean :fri
      t.boolean :sat
      t.boolean :sun
    end
  end
end
