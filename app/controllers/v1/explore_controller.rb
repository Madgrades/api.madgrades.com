class V1::ExploreController < ApiController
  def courses
    @grades = CourseGrade
    @grades = apply_filters(@grades)
    @grades = apply_sort(@grades)
    @grades = apply_page(@grades)
  end

  def subjects
    @grades = SubjectGrade
    @grades = apply_filters(@grades)
    @grades = apply_sort(@grades)
    @grades = apply_page(@grades)
  end

  def instructors
    @grades = InstructorGrade
    @grades = apply_filters(@grades)
    @grades = apply_sort(@grades)
    @grades = apply_page(@grades)
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

    model
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
