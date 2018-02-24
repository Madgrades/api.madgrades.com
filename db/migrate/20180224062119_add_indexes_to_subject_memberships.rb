class AddIndexesToSubjectMemberships < ActiveRecord::Migration[5.1]
  def change
    add_index :subject_memberships, :subject_code
    add_index :subject_memberships, :course_offering_uuid
  end
end
