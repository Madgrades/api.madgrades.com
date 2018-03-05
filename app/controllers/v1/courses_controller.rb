class V1::CoursesController < ApiController
  def index
    sort = params[:sort]
    order = (params[:order] || '').upcase!
    subject = params[:subject]
    instructor = params[:instructor]
    query = params[:query]
    number = params[:number]

    # ensure order is strictly ASC or DESC
    unless %w(ASC DESC).include?(order)
      order = 'DESC'
    end

    # if the user uses these sorting methods, we have a special query
    if %w(trending_recent trending_all trending_gpa_recent trending_gpa_all).include?(sort)
      @courses = Course.joins('JOIN course_trends ON course_trends.course_uuid = courses.uuid')

      if sort == 'trending_recent'
        @courses = @courses
                       .where("course_trends.duration = 'recent'")
                       .order("(last_count - first_count) / (last_term - first_term) #{order}")
      elsif sort == 'trending_all'
        @courses = @courses
                       .where("course_trends.duration = 'all'")
                       .order("(last_count - first_count) / (last_term - first_term) #{order}")
      elsif sort == 'trending_gpa_recent'
        @courses = @courses
                       .where("course_trends.duration = 'recent'")
                       .order("(last_gpa - first_gpa) / (last_term - first_term) #{order}")
      elsif sort == 'trending_gpa_all'
        @courses = @courses
                       .where("course_trends.duration = 'all'")
                       .order("(last_gpa - first_gpa) / (last_term - first_term) #{order}")
      else
        raise 'cant happen'
      end

      # prevents tiny 1-5 people courses and courses taught too long ago from trending
      earliest_allowed = -15 + CourseOffering
                          .select(:term_code)
                          .order(term_code: :desc)
                          .limit(1)
                          .first
                          .term_code
      @courses = @courses.where("last_count > 50 AND last_term > #{earliest_allowed} AND last_term - first_term > 2")
    elsif sort == 'name'
      @courses = Course.order("name #{order}")
    else
      @courses = Course.order("number #{order}")
    end

    # TODO: Untested, needed searchkick backend to test
    if query.present?
      uuids = Course.select(:uuid).search_without_page(query).map(&:uuid)
      @courses = @courses.where(uuid: uuids)
    end

    # filter by course number
    if number.present?
      @courses = @courses.where(number: number.split(',').map {|n| n.to_i})
    end

    # filter by subject membership
    if subject.present?
      subjects = Subject.where(code: subject.split(','))
      course_uuids = subjects.collect {|s| s.courses}.flatten.map {|c| c.uuid}
      @courses = @courses.where(uuid: course_uuids)
    end

    # filter by courses taught by an instructor
    if instructor.present?
      instructors = Instructor.where(id: instructor.split(','))
      course_uuids = instructors.collect {|i| i.courses}.flatten.map {|c| c.uuid}
      @courses = @courses.where(uuid: course_uuids)
    end

    @courses = @courses.page(params[:page]).per(params[:per_page])

    # for debugging
    # render json: @courses.to_sql
  end

  def show
    @course = Course.find(params[:id])
  end

  def search
    @courses = Course.search_with_page(params[:query], params[:page], params[:per_page])
    render :index
  end
end
