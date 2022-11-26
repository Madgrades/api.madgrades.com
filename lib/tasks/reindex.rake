task reindex: :environment do
  puts 'Reindexing courses into elasticsearch'
  Course.reindex
  puts 'Reindexing subjects into elasticsearch'
  Subject.reindex
  puts 'Reindexing instructors into elasticsearch'
  Instructor.reindex
  puts 'Done!'
end
