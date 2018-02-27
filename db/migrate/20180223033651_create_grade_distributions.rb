class CreateGradeDistributions < ActiveRecord::Migration[5.1]
  def change
    create_table :grade_distributions, id: false do |t|
      t.string :course_offering_uuid
      t.integer :section_number
      t.integer :a_count
      t.integer :ab_count
      t.integer :b_count
      t.integer :bc_count
      t.integer :c_count
      t.integer :d_count
      t.integer :f_count
      t.integer :s_count
      t.integer :u_count
      t.integer :cr_count
      t.integer :n_count
      t.integer :p_count
      t.integer :i_count
      t.integer :nw_count
      t.integer :nr_count
      t.integer :other_count
    end
  end
end
