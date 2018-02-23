class CreateCourses < ActiveRecord::Migration[5.1]
  def change
    create_table :courses, primary_key: :uuid, id: false do |t|
      t.string :uuid
      t.string :subject_code
      t.integer :number
    end
  end
end
