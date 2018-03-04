SELECT
  courses.uuid course_uuid,
  SUM(first.a_count) + SUM(first.ab_count) + SUM(first.b_count) + SUM(first.bc_count) +
      SUM(first.c_count) + SUM(first.d_count) + SUM(first.f_count) AS first_count,
  SUM(last.a_count) + SUM(last.ab_count) + SUM(last.b_count) + SUM(last.bc_count) +
      SUM(last.c_count) + SUM(last.d_count) + SUM(last.f_count) AS last_count,
  (SUM(first.a_count) * 4.0 + SUM(first.ab_count) * 3.5 + SUM(first.b_count) * 3.0 + SUM(first.bc_count) * 2.5 +
      SUM(first.c_count) * 2.0 + SUM(first.d_count) * 1.0 + SUM(first.f_count) * 0.0) /
      GREATEST(1, (SUM(first.a_count) * 4.0 + SUM(first.ab_count) * 4.0 + SUM(first.b_count) * 4.0 + SUM(first.bc_count) * 4.0 +
      SUM(first.c_count) * 4.0 + SUM(first.d_count) * 4.0 + SUM(first.f_count) * 4.0)) * 4.0 as first_gpa,
  (SUM(last.a_count) * 4.0 + SUM(last.ab_count) * 3.5 + SUM(last.b_count) * 3.0 + SUM(last.bc_count) * 2.5 +
      SUM(last.c_count) * 2.0 + SUM(last.d_count) * 1.0 + SUM(last.f_count) * 0.0) /
      GREATEST(1, (SUM(last.a_count) * 4.0 + SUM(last.ab_count) * 4.0 + SUM(last.b_count) * 4.0 + SUM(last.bc_count) * 4.0 +
      SUM(last.c_count) * 4.0 + SUM(last.d_count) * 4.0 + SUM(last.f_count) * 4.0)) * 4.0 as last_gpa,
  MIN(first.term_code) AS first_term,
  MIN(last.term_code) AS last_term,
  'all' AS duration
FROM courses
JOIN course_offering_grade_dists first ON
  first.course_uuid = courses.uuid AND
  first.term_code IN (
    SELECT MIN(c.term_code)
    FROM course_offering_grade_dists c
    WHERE c.course_uuid = first.course_uuid
  )
JOIN course_offering_grade_dists last ON
  last.course_uuid = courses.uuid AND
  last.term_code IN (
    SELECT MAX(term_code)
    FROM course_offering_grade_dists c
    WHERE c.course_uuid = last.course_uuid
  )
GROUP BY courses.uuid
HAVING first_term <> last_term AND first_count > 0 AND last_count > 0