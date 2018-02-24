unless grade_distribution.sum?
  json.term_code grade_distribution.term_code
  json.course_offering_uuid grade_distribution.course_offering_uuid
  json.section_number grade_distribution.section_number
end
json.extract! grade_distribution, :count, :gpa, :a_count, :ab_count, :b_count, :bc_count, :c_count, :d_count, :f_count, :s_count, :u_count, :cr_count, :n_count, :p_count, :i_count, :nw_count, :nr_count, :other_count
