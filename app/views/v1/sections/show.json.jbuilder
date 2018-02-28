json.partial! 'v1/sections/section', section: @section
json.course_offering_url course_offering_url(@section.course_offering_uuid)
json.schedule do
  json.partial! 'v1/schedules/schedule', schedule: @section.schedule
end
json.room do
  json.partial! 'v1/rooms/room', room: @section.room
end
json.instructors @section.instructors.each do |instructor|
  json.partial! 'v1/instructors/instructor', instructor: instructor
end