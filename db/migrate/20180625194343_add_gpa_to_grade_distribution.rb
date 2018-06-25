class AddGpaToGradeDistribution < ActiveRecord::Migration[5.1]
  def change
    add_column :grade_distributions, :gpa, :decimal, precision: 7, scale: 5
  end
end
