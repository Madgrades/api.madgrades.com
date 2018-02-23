class CreateTeachings < ActiveRecord::Migration[5.1]
  def change
    create_table :teachings do |t|
      t.string :section_uuid
      t.string :instructor_id
    end
  end
end
