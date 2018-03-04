task trends: :environment do
  puts 'Populating trends...'
  if CourseTrend.populate!
    puts 'Done!'
  else
    puts 'Please run rake grades:courses before this task.'
  end
end
