class CreateCourseOfferings < ActiveRecord::Migration[5.1]
  def change
    create_table :course_offerings, primary_key: :uuid, id: false do |t|
      t.string :uuid
      t.string :course_uuid
      t.integer :term_code
      t.string :name
    end
  end
end
