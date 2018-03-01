class Course < ApplicationRecord
  self.primary_key = :uuid
  searchkick word_start: [:name, :full_name], synonyms: [
      %w(i 1 one),
      %w(ii 2 two),
      %w(iii 3 three),
      %w(iv 4 four),
      %w(v 5 five),
      %w(vi 6 six),
      %w(vii 7 seven),
      %w(viii 8 eight),
      %w(ix 9 nine),
      %w(x 10 ten)
  ]

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
