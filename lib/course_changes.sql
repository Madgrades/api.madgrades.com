DROP VIEW IF EXISTS v_dists;
CREATE VIEW v_dists AS (
  SELECT *
  FROM (
         SELECT
           course_uuid,
           term_code,
           d.a_count + d.ab_count + d.b_count + d.bc_count + d.c_count + d.d_count +
           d.f_count                                  AS grade_count,
           4.0 * (d.a_count * 4.0 + d.ab_count * 3.5 + d.b_count * 3.0 +
                  d.bc_count * 2.5 + d.c_count * 2.0 + d.d_count * 1.0 + d.f_count * 0.0) /
           GREATEST(1, (d.a_count + d.ab_count + d.b_count + d.bc_count + d.c_count +
                        d.d_count + d.f_count) * 4.0) AS gpa
         FROM course_offering_grade_dists d
       ) AS dists
  WHERE dists.grade_count > 0
);

DROP VIEW IF EXISTS v_course_changes_all;
CREATE VIEW v_course_changes_all AS (
  SELECT
    dists.course_uuid,
    ROUND(SUM(
              (dists.term_code - grade_avgs.avg_term_code) *
              (dists.grade_count - grade_avgs.avg_grade_count)
          ) / GREATEST(1, SUM(POW(dists.term_code - grade_avgs.avg_term_code, 2))),
          5)                                                                           AS count_change,
    ROUND(SUM(
              (dists.term_code - grade_avgs.avg_term_code) *
              (dists.gpa - grade_avgs.avg_gpa)
          ) / GREATEST(1, SUM(POW(dists.term_code - grade_avgs.avg_term_code, 2))),
          5)                                                                           AS gpa_change,
    'all'                                                                              AS duration
  FROM v_dists dists
    JOIN (
           SELECT
             course_uuid,
             AVG(grade_count) AS avg_grade_count,
             AVG(gpa)         AS avg_gpa,
             AVG(term_code)   AS avg_term_code
           FROM v_dists
           GROUP BY course_uuid
         ) AS grade_avgs ON dists.course_uuid = grade_avgs.course_uuid
  GROUP BY dists.course_uuid
  ORDER BY gpa_change DESC
);

DROP VIEW IF EXISTS v_course_changes_recent;
CREATE VIEW v_course_changes_recent AS (
  SELECT
    dists.course_uuid,
    ROUND(SUM(
              (dists.term_code - grade_avgs.avg_term_code) *
              (dists.grade_count - grade_avgs.avg_grade_count)
          ) / GREATEST(1, SUM(POW(dists.term_code - grade_avgs.avg_term_code, 2))),
          5)                                                                           AS count_change,
    ROUND(SUM(
              (dists.term_code - grade_avgs.avg_term_code) *
              (dists.gpa - grade_avgs.avg_gpa)
          ) / GREATEST(1, SUM(POW(dists.term_code - grade_avgs.avg_term_code, 2))),
          5)                                                                           AS gpa_change,
    'recent'                                                                           AS duration
  FROM v_dists dists
    JOIN (
           SELECT
             course_uuid,
             AVG(grade_count) AS avg_grade_count,
             AVG(gpa)         AS avg_gpa,
             AVG(term_code)   AS avg_term_code
           FROM v_dists
           WHERE term_code > (SELECT MAX(term_code) FROM course_offering_grade_dists) - 2
           GROUP BY course_uuid
         ) AS grade_avgs ON dists.course_uuid = grade_avgs.course_uuid
  GROUP BY dists.course_uuid
  ORDER BY gpa_change DESC
);