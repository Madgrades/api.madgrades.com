namespace :grades do
  task courses: :environment do
    puts 'Courses...'
    CourseGrade.repopulate!
    puts 'Done!'
  end

  task instructors: :environment do
    puts 'Instructors...'
    InstructorGrade.repopulate!
    puts 'Done!'
  end

  task subjects: :environment do
    puts 'Subjects...'
    SubjectGrade.repopulate!
    puts 'Done!'
  end

  task :all => [:courses, :instructors, :subjects]
end

task :grades => 'grades:all'