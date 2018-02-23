json.uuid course_offering.uuid
json.course_uuid course_offering.uuid
json.term do
  json.name course_offering.term_name
  json.code course_offering.term_code
end
json.course_url course_url(course_offering.course_uuid)
json.url course_offering_url(course_offering)