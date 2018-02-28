class RemoveTimestampsFromSubject < ActiveRecord::Migration[5.1]
  def change
    remove_column :subjects, :created_at
    remove_column :subjects, :updated_at
  end
end
