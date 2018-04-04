json.cache! [:v1, @instructor, :grades], expires_in: 10.minutes do
  json.instructor_id @instructor.id
  json.cumulative do
    json.extract! @cumulative, :total, :a_count, :ab_count, :b_count, :bc_count, :c_count, :d_count, :f_count, :s_count, :u_count, :cr_count, :n_count, :p_count, :i_count, :nw_count, :nr_count, :other_count
  end
  json.course_offerings @grade_distributions.each do |offering|
    json.term_code offering[:term_code]
    json.course_uuid offering[:course_uuid]
    json.course_offering_uuid offering[:course_offering_uuid]
    json.cumulative do
      json.extract! offering[:cumulative], :total, :a_count, :ab_count, :b_count, :bc_count, :c_count, :d_count, :f_count, :s_count, :u_count, :cr_count, :n_count, :p_count, :i_count, :nw_count, :nr_count, :other_count
    end
    json.sections offering[:sections].each do |section_dist|
      json.section_number section_dist[:section_number]
      json.instructors section_dist[:instructors]
      json.extract! section_dist[:grades], :total, :a_count, :ab_count, :b_count, :bc_count, :c_count, :d_count, :f_count, :s_count, :u_count, :cr_count, :n_count, :p_count, :i_count, :nw_count, :nr_count, :other_count
    end
  end
end