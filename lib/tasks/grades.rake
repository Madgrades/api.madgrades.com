namespace :grades do
  task courses: :environment do
    puts 'Populating course grades...'
    CourseOfferingGradeDist.populate!
    put 'Done!'
  end
end
