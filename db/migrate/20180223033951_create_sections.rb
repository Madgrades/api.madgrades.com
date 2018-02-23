class CreateSections < ActiveRecord::Migration[5.1]
  def change
    create_table :sections, id: false do |t|
      t.string :uuid
      t.string :course_offering_uuid
      t.string :number
      t.string :section_type
      t.string :schedule_uuid
    end
  end
end
