task reindex: :environment do
  puts 'Reindexing...'
  Course.reindex
  Subject.reindex
  Instructor.reindex
  puts 'Done!'
end
