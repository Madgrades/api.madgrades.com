SELECT
  subject_code,
  SUM(a_count) + SUM(ab_count) + SUM(b_count) + SUM(bc_count) + SUM(c_count) + SUM(d_count) + SUM(f_count) AS gpa_total,
  AVG(a_count + ab_count + b_count + bc_count + c_count + d_count + f_count) AS count_avg,
  (
    (SUM(a_count) * 4.0 + SUM(ab_count) * 3.5 + SUM(b_count) * 3 + SUM(bc_count) * 2.5 + SUM(c_count) * 2 + SUM(d_count) * 1 + SUM(f_count) * 0) /
    GREATEST(1, (SUM(a_count) + SUM(ab_count) + SUM(b_count) + SUM(bc_count) + SUM(c_count) + SUM(d_count) + SUM(f_count)))
  ) AS gpa
FROM subject_memberships
JOIN course_offerings ON course_offerings.uuid = subject_memberships.course_offering_uuid
JOIN sections ON sections.course_offering_uuid = course_offerings.uuid
JOIN grade_distributions ON grade_distributions.section_number = sections.number AND grade_distributions.course_offering_uuid = course_offerings.uuid
GROUP BY subject_code;