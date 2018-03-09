class CreateInstructorGradeDists < ActiveRecord::Migration[5.1]
  def change
    create_table :instructor_grade_dists, id: false do |t|
      t.string :course_uuid
      t.integer :instructor_id
      t.integer :term_code
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

    add_index :instructor_grade_dists, :course_uuid
    add_index :instructor_grade_dists, :instructor_id
    add_index :instructor_grade_dists, :term_code
  end
end
