class V1::ExploreController < ApiController
  def courses
    subject_param = params[:subject] || params[:subjects]
    instructor_param = params[:instructor] || params[:instructors]
    @grades = nil
    course_uuids = nil

    if subject_param.present?
      subjects = Subject.where(code: subject_param.split(","))
      uuids = subjects.collect {|s| s.courses}.flatten.map(&:uuid)
      
      if course_uuids.present?
        course_uuids &= uuids
      else
        course_uuids = uuids
      end
    end

    if instructor_param.present?
      instructors = Instructor.where(id: instructor_param.split(",").map(&:to_i))
      uuids = instructors.collect {|i| i.courses}.flatten.map(&:uuid)

      if course_uuids.present?
        course_uuids &= uuids
      else
        course_uuids = uuids
      end
    end

    @grades = CourseGrade

    if course_uuids != nil
      @grades = @grades.where(course_uuid: course_uuids)
    end

    @grades = apply_params(@grades)
  end

  def subjects
    @grades = SubjectGrade
    @grades = apply_params(@grades)
  end

  def instructors
    subject_param = params[:subject] || params[:subjects]

    if subject_param.present?
      subject_codes = subject_param.split(",")
      @grades = InstructorGrade
                  .select('DISTINCT instructor_grades.*')
                  .joins('JOIN teachings ON teachings.instructor_id = instructor_grades.instructor_id')
                  .joins('JOIN sections ON sections.uuid = teachings.section_uuid')
                  .joins('JOIN subject_memberships ON subject_memberships.course_offering_uuid = sections.course_offering_uuid')
                  .joins('JOIN subjects ON subjects.code = subject_memberships.subject_code')
                  .where('subjects.code IN (?)', subject_codes)
    else
      @grades = InstructorGrade
    end

    @grades = apply_params(@grades)
  end

  private

  def apply_params(model)
    apply_page(apply_sort(apply_filters(model)))
  end

  def apply_page(model)
    model.page(params[:page]).per(params[:per_page])
  end

  def apply_filters(model)
    min_gpa_total = (params[:min_gpa_total] || '0').to_i
    min_count_avg = (params[:min_count_avg] || '0').to_i

    model = model.where('gpa_total >= ?', min_gpa_total)
    model = model.where('count_avg >= ?', min_count_avg)
  end

  def apply_sort(model)
    sort = (params[:sort] || '').downcase
    order = (params[:order] || '').downcase

    unless %w(gpa_total count_avg gpa).include?(sort)
      sort = 'gpa_total'
    end

    unless %w(asc desc).include?(order)
      order = 'desc'
    end

    model.order("#{sort} #{order}")
  end
end
