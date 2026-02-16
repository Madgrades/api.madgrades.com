json.partial! 'v1/sections/section', section: @section
json.course_offering_url v1_course_offering_url(@section.course_offering_uuid)
if @section.schedule.present?
  json.schedule do
    json.partial! 'v1/schedules/schedule', schedule: @section.schedule
  end
else
  json.schedule nil
end
if @section.room.present?
  json.room do
    json.partial! 'v1/rooms/room', room: @section.room
  end
else
  json.room nil
end
json.instructors @section.instructors.each do |instructor|
  json.partial! 'v1/instructors/instructor', instructor: instructor
end