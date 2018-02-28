class Course < ApplicationRecord
  self.primary_key = :uuid
  searchkick word_start: [:name, :full_name]

  default_scope { order(number: :asc) }

  def self.search_with_page(query, page, per_page)
    per_page = [per_page || Kaminari.config.default_per_page, Kaminari.config.max_per_page].min
    Course.search(query,
                  page: page,
                  per_page: per_page,
                  match: :word_start,
                  fields: [:full_name, :subjects])
  end

  def search_data
    {
        subjects: subject_names.join(' '),
        full_name: "#{subject_names.join(' ')} #{number} #{names.join(' ')}"
    }
  end

  def subject_memberships
    SubjectMembership
        .joins('JOIN course_offerings ON course_offerings.uuid = subject_memberships.course_offering_uuid')
        .where('course_offerings.course_uuid = ?', uuid)
        .distinct
  end

  def subjects
    Subject
        .joins('JOIN subject_memberships ON subject_memberships.subject_code = subjects.code')
        .joins('JOIN course_offerings ON course_offerings.uuid = subject_memberships.course_offering_uuid')
        .where('course_offerings.course_uuid = ?', uuid)
        .distinct
  end

  def names
    course_offerings.map(&:name).uniq
  end

  def subject_names
    subjects.map(&:name)
  end

  def subject_codes
    subjects.map(&:code)
  end

  def course_offerings
    CourseOffering.where(course_uuid: uuid)
  end

  def to_param
    uuid
  end
end
