json.partial! "course_offerings/course_offering", course_offering: @course_offering
json.sections @course_offering.sections.each do |section|
  json.partial! "sections/section", section: section
end
