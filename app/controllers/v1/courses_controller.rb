class V1::CoursesController < ApiController
  def index
    sort = params[:sort]
    order = (params[:order] || '').upcase!
    subject = params[:subject] || params[:subjects]
    instructor = params[:instructor] || params[:instructors]
    query = params[:query]
    number = params[:number] || params[:numbers]
    page = params[:page]
    per_page = params[:per_page]

    # ensure order is strictly ASC or DESC
    unless %w(ASC DESC).include?(order)
      order = 'ASC'
    end

    sorted = true

    # if the user uses these sorting methods, we have a special query
    if sort == 'name'
      @courses = Course.order("name #{order}")
    elsif sort == 'number'
      @courses = Course.order("number #{order}")
    elsif sort == 'relevance' || true
      if query.present?
        # default to no sort if query is present
        @courses = Course
        sorted = false
      else
        # default to number order
        @courses = Course.order("number #{order}")
      end
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

  def grades
    @course = Course.find(params[:id])
    course_offering_uuids = @course.offerings.map(&:uuid)
    @grade_distributions = GradeDistribution.select('instructors.id AS i_id, instructors.name AS i_name, grade_distributions.*')
                               .joins('JOIN sections ON sections.number = grade_distributions.section_number AND sections.course_offering_uuid = grade_distributions.course_offering_uuid')
                               .joins('JOIN teachings ON teachings.section_uuid = sections.uuid')
                               .joins('JOIN instructors ON instructors.id = teachings.instructor_id')
                               .where(course_offering_uuid: course_offering_uuids)
                               .distinct

    @cumulative = @grade_distributions.inject(GradeDistribution.zero) {|x, y| x + y}

    @grade_distributions = @grade_distributions.to_a.group_by {|d| d.term_code}

    @grade_distributions = @grade_distributions.map do |term_code, section_dists|
      res = {}
      res[:term_code] = term_code
      res[:cumulative] = section_dists.inject(GradeDistribution.zero) {|x, y| x + y}
      res[:sections] = []

      sections = section_dists.group_by {|d| d.section_number}
      sections.each do |number, dists|
        dist = {}
        dist[:grades] = GradeDistribution.zero + dists[0]
        dist[:section_number] = number
        dist[:instructors] = dists.map {|d| {id: d.i_id, name: d.i_name}}
        res[:sections].push(dist)
      end
      res
    end

    @grade_distributions.sort! {|a,b| b[:term_code] - a[:term_code]}
  end
end
