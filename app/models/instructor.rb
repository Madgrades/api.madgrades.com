class Instructor < ApplicationRecord
  self.primary_key = :id
  searchkick word_start: [:name]

  default_scope { order(id: :asc) }


  def self.search_with_page(query, page, per_page)
    per_page = [per_page || Kaminari.config.default_per_page, Kaminari.config.max_per_page].min
    Instructor.search(query,
                  page: page,
                  per_page: per_page,
                  match: :word_start,
                  fields: [:name])
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
end
