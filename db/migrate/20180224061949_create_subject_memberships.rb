class CreateSubjectMemberships < ActiveRecord::Migration[5.1]
  def change
    create_table :subject_memberships, id: false do |t|
      t.string :subject_code
      t.string :course_offering_uuid
    end
  end
end
