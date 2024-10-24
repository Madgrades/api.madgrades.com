class Subject < ApplicationRecord
  self.primary_key = :code

  searchkick text_middle: [:code, :name, :abbreviation]

  default_scope { order(code: :asc) }

  def self.search_with_page(query, page, per_page)
    per_pages = [Kaminari.config.default_per_page, Kaminari.config.max_per_page]
    per_pages.push(per_page.to_i) if per_page.present?
    Subject.search(query,
                  page: page,
                  per_page: per_pages.min,
                  match: :text_middle,
                  fields: [:code, :name, :abbreviation])
  end

  def search_data
    {
        code: code,
        name: name,
        abbreviation: abbreviation
    }
  end

  def to_param
    code
  end

  def courses
    Course
      .joins('JOIN course_offerings ON course_offerings.course_uuid = courses.uuid')
      .joins('JOIN subject_memberships ON subject_memberships.course_offering_uuid = course_offerings.uuid')
      .where('subject_memberships.subject_code = ?', code)
      .distinct
  end
end
