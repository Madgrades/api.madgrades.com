class CreateTeachings < ActiveRecord::Migration[5.1]
  def change
    create_table :teachings, id: false do |t|
      t.string :section_uuid
      t.integer :instructor_id
    end
  end
end
