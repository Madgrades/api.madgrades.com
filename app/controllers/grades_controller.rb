class GradesController < ApplicationController
  def course
    course = Course.find(params[:uuid])
    all = GradeDistribution
               .joins('INNER JOIN course_offerings ON grade_distributions.course_offering_uuid = course_offerings.uuid')
               .joins('INNER JOIN courses ON course_offerings.course_uuid = courses.uuid')
               .where('courses.uuid = ?', course.uuid)
    render_all(all)
  end

  def course_offering
    course_offering = CourseOffering.find(params[:uuid])
    all = GradeDistribution.where(course_offering_uuid: course_offering.uuid)
    render_all(all)
  end

  def instructor
    instructor = Instructor.find(params[:id])
    all = GradeDistribution
               .joins('JOIN sections ON sections.number = grade_distributions.section_number AND sections.course_offering_uuid = grade_distributions.course_offering_uuid')
               .joins('JOIN teachings ON teachings.section_uuid = sections.uuid')
               .where('teachings.instructor_id = ?', instructor.id)
               .distinct
    render_all(all)
  end

  private

    def render_all(all)
      @course_offerings = Set.new
      all.each do |grade_dist|
        curr = {}
        curr['term_code'] = grade_dist.term_code
        curr['course_offering_uuid'] = grade_dist.course_offering_uuid
        curr['cumulative'] = GradeDistribution.zero
        curr['sections'] = []
        added_already = false

        @course_offerings.each do |term|
          if grade_dist.term_code == term['term_code']
            curr = term
            added_already = true
          end
        end

        curr['cumulative'] = curr['cumulative'] + grade_dist
        curr['sections'].push(grade_dist)

        @course_offerings.add(curr) unless added_already
      end
      @grade_distribution = all.to_a.sum

      render :show
    end
end
