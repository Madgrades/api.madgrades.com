class Course < ApplicationRecord
  require 'csv'
  self.primary_key = :uuid
  searchkick text_middle: [:names, :uuid], synonyms: -> { CSV.read("#{Rails.root}/lib/course_synonyms.csv") }

  def self.prepare_query(query)
    if query.present?
      # convert "math340" to "math 340" for example
      query.gsub!(/([A-z])([0-9])/, '\1 \2')
    end
    query
  end

  def self.search_with_page(query, page, per_page, where={})
    per_pages = [Kaminari.config.default_per_page, Kaminari.config.max_per_page]
    per_pages.push(per_page.to_i) if per_page.present?
    Course.search(prepare_query(query),
                  page: page,
                  per_page: per_pages.min,
                  where: where,
                  misspellings: {below: 5},
                  match: :text_middle,
                  fields: [:names, :uuid])
  end

  def self.search_without_page(query)
    Course.search(prepare_query(query), misspellings: {below: 5})
  end

  def search_data
    {
        names: "#{subject_names.join(' ')} #{subject_initials.join(' ')} #{subject_abbrevs.join(' ')} #{names.join(' ')} #{number}",
        uuid: uuid
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

  def subject_initials
    subject_names.map { |name| name.split(' ').collect { |s| s[0] }.join('') }
  end

  def names
    offerings.map(&:name).uniq
  end

  def subject_names
    subjects.map(&:name)
  end

  def subject_codes
    subjects.map(&:code)
  end

  def subject_abbrevs
    subjects.map(&:abbreviation)
  end

  def offerings
    CourseOffering.where(course_uuid: uuid)
  end

  def to_param
    uuid
  end
end
