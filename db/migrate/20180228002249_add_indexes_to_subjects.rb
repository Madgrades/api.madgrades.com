class AddIndexesToSubjects < ActiveRecord::Migration[5.1]
  def change
    add_index :subjects, :code, unique: true
    add_index :subjects, :name
  end
end
