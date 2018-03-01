namespace :grades do
  task courses: :environment do
    puts 'Populating course grades...'
    CourseOfferingGradeDist.populate!
    puts 'Done!'
  end
end
