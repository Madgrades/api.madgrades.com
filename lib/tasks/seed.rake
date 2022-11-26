namespace :seed do
  task base_tables: :environment do
    options = {}
    parser = OptionParser.new
    parser.banner = 'Usage: rake seed -- [options]'
    parser.on('-p NAME', '--path=NAME') do |path|
      options[:path] = path
    end
    parser.parse!(parser.order!(ARGV) {})
    if options[:path].nil? || options[:path].empty?
      abort(parser.help)
    end

    puts 'Deleting base tables (this may take a while)...'
    CourseOffering.delete_all
    Course.delete_all
    GradeDistribution.delete_all
    Instructor.delete_all
    Room.delete_all
    Schedule.delete_all
    Section.delete_all
    SubjectMembership.delete_all
    Subject.delete_all
    Teaching.delete_all
    
    glob = Dir.glob("#{options[:path]}/*.sql")
    puts "Seeding tables from: #{options[:path]}/*.sql (#{glob})"
    glob.each do |sql_file|
      puts "Running #{sql_file}"
      query = File.read(sql_file)
      ActiveRecord::Base.connection.execute(query)
    end
    puts 'Done!'
  end

  task corrections: :environment do
    puts "Running corrections"
    Dir.glob("#{Rails.root}/lib/corrections/*.sql").each do |sql_file|
      puts "Running #{sql_file}"
      query = File.read(sql_file)
      ActiveRecord::Base.connection.execute(query)
    end
  end

  task grades: :environment do
    Rake::Task["grades"].invoke
  end
  
  task reindex: :environment do
    Rake::Task["reindex"].invoke
  end

  task :all => [:base_tables, :corrections, :grades, :reindex]
end

task :seed => 'seed:all'