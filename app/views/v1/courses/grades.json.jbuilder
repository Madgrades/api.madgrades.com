json.cache! [:v1, @course, :grades], expires_in: 10.minutes do
  json.course_uuid @course.uuid
  json.cumulative do
    json.extract! @cumulative, :gpa, :gpa_total, :total, :a_count, :ab_count, :b_count, :bc_count, :c_count, :d_count, :f_count, :s_count, :u_count, :cr_count, :n_count, :p_count, :i_count, :nw_count, :nr_count, :other_count
  end
  json.course_offerings @grade_distributions.each do |grade_dist|
    json.term_code grade_dist.term_code
    json.extract! (GradeDistribution.zero + grade_dist), :gpa, :gpa_total, :total, :a_count, :ab_count, :b_count, :bc_count, :c_count, :d_count, :f_count, :s_count, :u_count, :cr_count, :n_count, :p_count, :i_count, :nw_count, :nr_count, :other_count
  end
  json.instructors @instructors do |instructor|
    json.id instructor[:id]
    json.cumulative do
      json.extract! instructor[:cumulative], :gpa, :gpa_total, :total, :a_count, :ab_count, :b_count, :bc_count, :c_count, :d_count, :f_count, :s_count, :u_count, :cr_count, :n_count, :p_count, :i_count, :nw_count, :nr_count, :other_count
    end
    json.course_offerings instructor[:course_offerings] do |dist|
      json.term_code dist[:term_code]
      json.extract! (GradeDistribution.zero + dist), :gpa, :gpa_total, :total, :a_count, :ab_count, :b_count, :bc_count, :c_count, :d_count, :f_count, :s_count, :u_count, :cr_count, :n_count, :p_count, :i_count, :nw_count, :nr_count, :other_count
    end
  end
end