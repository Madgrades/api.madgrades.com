class SubjectGrade < ApplicationRecord
  def self.repopulate!
    SubjectGrade.delete_all
    query = File.read("#{Rails.root}/lib/populate_subject_grades.sql")
    ActiveRecord::Base.connection.execute("INSERT INTO subject_grades #{query}")
    true
  end

  def subject
    Subject.find(subject_code)
  end
end
