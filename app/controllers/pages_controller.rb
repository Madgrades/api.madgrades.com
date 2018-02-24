class PagesController < ApplicationController
  def index
    render json: {
        message: 'hey :)',
        examples: {
            courses: courses_url,
            courses_search: courses_search_url(query: 'Computer'),
            instructors: instructors_url,
            instructors_search: instructors_search_url(query: 'Michael Leckrone'),
            instructor_grades: instructor_grades_url(Instructor.first.id),
            course_grades: course_grades_url(Course.first.id),
            course_offering_grades: course_offering_grades_url(CourseOffering.first.id)
        }
    }
  end
end
