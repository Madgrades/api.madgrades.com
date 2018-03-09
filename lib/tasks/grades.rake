namespace :grades do
  task courses: :environment do
    puts 'Populating course grades...'
    CourseOfferingGradeDist.populate!
    puts 'Done!'
  end

  task instructors: :environment do
    puts 'Populating instructor grades...'
    InstructorGradeDist.populate!
    puts 'Done!'
  end
end
