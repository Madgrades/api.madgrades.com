DELETE FROM teachings
WHERE (section_uuid, instructor_id) IN (
    SELECT *
    FROM (
        SELECT teachings.*
        FROM course_offerings
          JOIN sections ON (
            course_offerings.uuid = sections.course_offering_uuid
          )
          JOIN teachings ON (sections.uuid = teachings.section_uuid)
          JOIN instructors ON (teachings.instructor_id = instructors.id)
        WHERE course_offerings.course_uuid = 'ce2189ea-6319-33c5-a127-388c6ccb0031'
          AND course_offerings.term_code = 1204
          AND instructors.id = 5444001
      ) AS tmp
  );