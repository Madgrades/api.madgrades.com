json.partial! 'api/sections/section', section: @section
json.course_offering_url course_offering_url(@section.course_offering_uuid)
json.schedule do
  json.partial! 'api/schedules/schedule', schedule: @section.schedule
end
json.room do
  json.partial! 'api/rooms/room', room: @section.room
end
json.instructors @section.instructors.each do |instructor|
  json.partial! 'api/instructors/instructor', instructor: instructor
end