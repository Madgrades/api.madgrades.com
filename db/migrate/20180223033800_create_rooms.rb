class CreateRooms < ActiveRecord::Migration[5.1]
  def change
    create_table :rooms, primary_key: :uuid, id: false do |t|
      t.string :uuid
      t.string :facility_code
      t.string :room_code
    end
  end
end
