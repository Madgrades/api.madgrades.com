namespace :grades do
  task courses: :environment do
    puts 'Seeding course_grades (this may take a while)'
    CourseGrade.repopulate!
  end

  task instructors: :environment do
    puts 'Seeding instructor_grades (this may take a while)'
    InstructorGrade.repopulate!
  end

  task subjects: :environment do
    puts 'Seeding subject_grades (this may take a while)'
    SubjectGrade.repopulate!
  end

  task :all => [:courses, :instructors, :subjects]
end

task :grades => 'grades:all'