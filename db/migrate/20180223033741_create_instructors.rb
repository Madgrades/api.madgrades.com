class CreateInstructors < ActiveRecord::Migration[5.1]
  def change
    create_table :instructors, primary_key: :id, id: false do |t|
      t.string :id
      t.string :name
    end
  end
end
