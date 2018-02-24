json.partial! "sections/section", section: @section
json.course_offering_url course_offering_url(@section.course_offering_uuid)
json.schedule do
  json.partial! "schedules/schedule", schedule: @section.schedule
end
json.room do
  json.partial! "rooms/room", room: @section.room
end
json.instructors @section.instructors.each do |instructor|
  json.partial! "instructors/instructor", instructor: instructor
end