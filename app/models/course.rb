class Course < ApplicationRecord
  self.primary_key = :uuid
  searchkick word_start: [:name, :subjects, :number]

  default_scope { order(number: :asc) }

  def self.search_with_page(query, page, per_page)
    per_page = [per_page || Kaminari.config.default_per_page, Kaminari.config.max_per_page].min
    Course.search(query,
                  page: page,
                  per_page: per_page,
                  match: :word_start,
                  fields: [:name, :subjects, :number])
  end

  def search_data
    {
        name: names.join(' '),
        subjects: subjects.join(' '),
        number: number
    }
  end

  def subject_memberships
    SubjectMembership
        .joins('JOIN course_offerings ON course_offerings.uuid = subject_memberships.course_offering_uuid')
        .where('course_offerings.course_uuid = ?', uuid)
        .distinct
  end

  def names
    course_offerings.map(&:name).uniq
  end

  def subjects
    # todo: have a separate table for subjects
    subject_memberships.map(&:subject_code).uniq
  end

  def course_offerings
    CourseOffering.where(course_uuid: uuid)
  end

  def to_param
    uuid
  end
end
