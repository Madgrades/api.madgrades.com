class Instructor < ApplicationRecord
  require 'csv'
  self.primary_key = :id
  searchkick word_start: [:name], synonyms: -> { CSV.read("#{Rails.root}/lib/nicknames.csv") }

  default_scope { order(id: :asc) }

  def self.search_with_page(query, page, per_page)
    per_pages = [Kaminari.config.default_per_page, Kaminari.config.max_per_page]
    per_pages.push(per_page.to_i) if per_page.present?
    Instructor.search(query,
                  page: page,
                  per_page: per_pages.min,
                  misspellings: {below: 5})
  end

  def search_data
    {
        name: name
    }
  end

  def teachings
    Teaching.where(instructor_id: id)
  end

  def sections
    Section.where('uuid IN (?)', teachings.map(&:section_uuid))
  end

  def courses
    Course
        .joins('JOIN course_offerings ON course_offerings.course_uuid = courses.uuid')
        .joins('JOIN sections ON sections.course_offering_uuid = course_offerings.uuid')
        .joins('JOIN teachings ON teachings.section_uuid = sections.uuid')
        .where('teachings.instructor_id = ?', id)
        .distinct
  end
end
