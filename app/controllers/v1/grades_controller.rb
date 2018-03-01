class V1::GradesController < ApiController
  def course
    course = Course.find(params[:id])
    all = CourseOfferingGradeDist.where(course_uuid: course.uuid)
    render_all(all)
  end

  def course_offering
    course_offering = CourseOffering.find(params[:id])
    all = GradeDistribution.where(course_offering_uuid: course_offering.uuid)
    render_all(all)
  end

  def term
    term = params[:id]
    all = GradeDistribution
              .joins('JOIN course_offerings ON course_offerings.uuid = grade_distributions.course_offering_uuid')
              .where('course_offerings.term_code = ?', term)
              .distinct
    render_all(all)
  end

  def section
    section = Section.find(params[:id])
    all = GradeDistribution
              .joins('JOIN course_offerings ON course_offerings.uuid = grade_distributions.course_offering_uuid')
              .joins('JOIN sections ON sections.course_offering_uuid = course_offerings.uuid')
              .where('sections.uuid = ?', section.uuid)
              .where(section_number: section.number)
              .distinct
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
      @course_offerings = []
      all.each do |grade_dist|
        curr = {}
        curr['term_code'] = grade_dist.term_code
        curr['cumulative'] = GradeDistribution.zero
        if grade_dist.has_attribute?('section_number')
          curr['sections'] = []
        end
        added_already = false

        @course_offerings.each do |term|
          if grade_dist.term_code == term['term_code']
            curr = term
            added_already = true
          end
        end

        curr['cumulative'] = curr['cumulative'] + grade_dist
        if grade_dist.has_attribute?('section_number')
          curr['sections'].push(grade_dist)
        end

        @course_offerings.push(curr) unless added_already
      end

      # sort by term code descending, recent first
      @course_offerings.sort!{ |a, b| b['term_code'] - a['term_code'] }

      # we start the summation with a non-term-affiliated grade distribution, zero
      @grade_distribution = ([GradeDistribution.zero] + all).to_a.sum

      render :show
    end
end
