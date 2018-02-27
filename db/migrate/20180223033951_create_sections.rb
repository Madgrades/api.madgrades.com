class CreateSections < ActiveRecord::Migration[5.1]
  def change
    create_table :sections, id: false do |t|
      t.string :uuid
      t.string :course_offering_uuid
      t.string :section_type
      t.integer :number
      t.string :room_uuid
      t.string :schedule_uuid
    end
  end
end
