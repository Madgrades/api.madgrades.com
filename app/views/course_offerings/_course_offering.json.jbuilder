json.extract! course_offering, :uuid, :course_uuid, :term_code, :name
json.url course_offering_url(course_offering)
json.sections course_offering.sections.each do |section|
  json.partial! "sections/section", section: section
end