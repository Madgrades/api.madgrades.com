class AddSearchIndexes < ActiveRecord::Migration[5.1]
  def change
    add_index :course_offerings, :term_code
    add_index :course_trends, :course_uuid
    add_index :course_trends, :duration
  end
end
