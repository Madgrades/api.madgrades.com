json.partial! "sections/section", section: @section
json.schedule do
  json.partial! "schedules/schedule", schedule: @section.schedule
end
json.instructors @section.instructors.each do |instructor|
  json.partial! "instructors/instructor", instructor: instructor
end
if @section.grade_distribution
  json.grade_distribution do
    json.partial! "grade_distributions/grade_distribution", grade_distribution: @section.grade_distribution
  end
else
  json.grade_distribution nil
end