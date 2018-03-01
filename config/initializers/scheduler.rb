scheduler = Rufus::Scheduler::singleton

def populate_course_grades
  course_offering_count = GradeDistribution.select(:course_uuid).group(:course_uuid).count

  if course_offering_count != CourseOfferingGradeDist.count
    CourseOfferingGradeDist.populate!
  end
end

unless defined?(Rails::Console) || File.split($0).last == 'rake'
  scheduler.every '7d' do
    populate_course_grades
  end
end