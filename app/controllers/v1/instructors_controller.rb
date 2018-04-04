class V1::InstructorsController < ApiController
  def index
    query = params[:query]

    if query.present?
      @instructors = Instructor.search_with_page(params[:query], params[:page], params[:per_page])
    else
      @instructors = Instructor.page(params[:page]).per(params[:per_page])
    end
  end

  def show
    @instructor = Instructor.find(params[:id])
  end

  def grades
    @instructor = Instructor.find(params[:id])
    course_offering_uuids = @instructor.teachings.map {|t| t.section.course_offering }.uniq
    @grade_distributions = GradeDistribution.select('instructors.id AS i_id, instructors.name AS i_name, grade_distributions.*')
                               .joins('JOIN sections ON sections.number = grade_distributions.section_number AND sections.course_offering_uuid = grade_distributions.course_offering_uuid')
                               .joins('JOIN teachings ON teachings.section_uuid = sections.uuid')
                               .joins('JOIN instructors ON instructors.id = teachings.instructor_id')
                               .where(course_offering_uuid: course_offering_uuids)
                               .distinct

    @cumulative = @grade_distributions.inject(GradeDistribution.zero) {|x, y| x + y}

    @grade_distributions = @grade_distributions.to_a.group_by {|d| [d.term_code, d.course_offering.course_uuid, d.course_offering.uuid ] }

    @grade_distributions = @grade_distributions.map do |group, section_dists|
      res = {}
      res[:term_code] = group[0]
      res[:course_uuid] = group[1]
      res[:course_offering_uuid] = group[2]
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
