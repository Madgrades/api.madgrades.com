json.partial! 'v1/course_offerings/course_offering', course_offering: @course_offering
json.subjects @course_offering.subjects
json.course_url course_url(@course_offering.course_uuid)
json.sections @course_offering.sections.each do |section|
  json.partial! 'v1/sections/section', section: section
end
