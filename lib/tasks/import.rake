require 'csv'

# Todo: This takes way too long, and there's only 3 terms so far :|

namespace :import do
  desc "import courses"
  task courses: :environment do
    puts "importing courses"
    CSV.foreach('courses.csv', :headers => true) do |row|
      Course.create!(row.to_hash)
    end
  end

  desc "import offerings"
  task course_offerings: :environment do
    puts "importing course offerings"
    CSV.foreach('course_offerings.csv', :headers => true) do |row|
      CourseOffering.create!(row.to_hash)
    end
  end

  desc "import grades"
  task grade_distributions: :environment do
    puts "importing grades"
    CSV.foreach('grade_distributions.csv', :headers => true) do |row|
      GradeDistribution.create!(row.to_hash)
    end
  end

  desc "import instructors"
  task instructors: :environment do
    puts "importing instructors"
    CSV.foreach('instructors.csv', :headers => true) do |row|
      Instructor.create!(row.to_hash)
    end
  end

  desc "import rooms"
  task rooms: :environment do
    puts "importing rooms"
    CSV.foreach('rooms.csv', :headers => true) do |row|
      Room.create!(row.to_hash)
    end
  end

  desc "import schedules"
  task schedules: :environment do
    puts "importing schedules"
    CSV.foreach('schedules.csv', :headers => true) do |row|
      Schedule.create!(row.to_hash)
    end
  end

  desc "import sections"
  task sections: :environment do
    puts "importing sections"
    CSV.foreach('sections.csv', :headers => true) do |row|
      Section.create!(row.to_hash)
    end
  end

  desc "import teachings"
  task teachings: :environment do
    puts "importing teachings"
    CSV.foreach('teachings.csv', :headers => true) do |row|
      Teaching.create!(row.to_hash)
    end
  end
end

desc "import all"
task :import do
  Rake::Task['import:courses'].invoke
  Rake::Task['import:course_offerings'].invoke
  Rake::Task['import:grade_distributions'].invoke
  Rake::Task['import:instructors'].invoke
  Rake::Task['import:rooms'].invoke
  Rake::Task['import:schedules'].invoke
  Rake::Task['import:sections'].invoke
  Rake::Task['import:teachings'].invoke
end
