class PagesController < ApplicationController
  def index
    render json: {
        message: 'hey :)',
        examples: {
            courses: courses_url,
            instructors: instructors_url,
            instructor_grades: instructor_grades_url(:id => Instructor.first.id),
            course_grades: course_grades_url(:uuid => Course.first.id),
            course_offering_grades: course_offering_grades_url(:uuid => CourseOffering.first.id)
        }
    }
  end
end
