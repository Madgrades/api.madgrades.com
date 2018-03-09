class V1::CoursesController < ApiController
  def index
    sort = params[:sort]
    order = (params[:order] || '').upcase!
    subject = params[:subject]
    instructor = params[:instructor]
    query = params[:query]
    number = params[:number]
    page = params[:page]
    per_page = params[:per_page]

    # ensure order is strictly ASC or DESC
    unless %w(ASC DESC).include?(order)
      order = 'ASC'
    end

    sorted = true

    # if the user uses these sorting methods, we have a special query
    if %w(trending_recent trending_all trending_gpa_recent trending_gpa_all).include?(sort)
      @courses = Course.joins('JOIN course_changes ON course_changes.course_uuid = courses.uuid')

      if sort == 'trending_recent'
        @courses = @courses
                       .where("course_changes.duration = 'recent'")
                       .order("count_change #{order}")
      elsif sort == 'trending_all'
        @courses = @courses
                       .where("course_changes.duration = 'all'")
                       .order("count_change #{order}")
      elsif sort == 'trending_gpa_recent'
        @courses = @courses
                       .where("course_changes.duration = 'recent'")
                       .order("gpa_change #{order}")
      elsif sort == 'trending_gpa_all'
        @courses = @courses
                       .where("course_changes.duration = 'all'")
                       .order("gpa_change #{order}")
      end

      # # prevents tiny 1-5 people courses and courses taught too long ago from trending
      # earliest_allowed = -15 + CourseOffering
      #                     .select('MAX(term_code) as term_code')
      #                     .first
      #                     .term_code
      # @courses = @courses.where("last_count > 50 AND last_term > #{earliest_allowed} AND last_term - first_term > 2")
    elsif sort == 'name'
      @courses = Course.order("name #{order}")
    elsif sort == 'number'
      @courses = Course.order("number #{order}")
    elsif sort == 'relevance' || true
      @courses = Course
      sorted = false
    end

    filters = {}

    # filter by course number
    if number.present?
      filters['number'] = number.split(',').map {|n| n.to_i}
    end

    # filter by subject membership
    if subject.present?
      subjects = Subject.where(code: subject.split(','))
      course_uuids = subjects.collect {|s| s.courses}.flatten.map {|c| c.uuid}
      filters['uuid'] = course_uuids
    end

    # filter by courses taught by an instructor
    if instructor.present?
      instructors = Instructor.where(id: instructor.split(','))
      course_uuids = instructors.collect {|i| i.courses}.flatten.map {|c| c.uuid}

      if filters.include?('uuid')
        filters['uuid'] &= course_uuids
      else
        filters['uuid'] = course_uuids
      end
    end

    searchkick = false

    # TODO: Untested, needed searchkick backend to test
    if query.present?
      if sorted
        search_results = Course.search_without_page(query).map(&:uuid)
        if filters.include?('uuid')
          filters['uuid'] &= search_results
        else
          filters['uuid'] = search_results
        end
      else
        @courses = Course.search_with_page(query, page, per_page, filters)
        searchkick = true
      end
    end

    unless searchkick
      @courses = @courses.where(filters).page(page).per(per_page)
    end

    # for debugging
    # render json: @courses.to_sql
  end

  def show
    @course = Course.find(params[:id])
  end
end
