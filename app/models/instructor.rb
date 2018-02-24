class Instructor < ApplicationRecord
  self.primary_key = :id

  default_scope { order(id: :asc) }

  def self.search(query)
    Instructor.where('id LIKE :query OR name LIKE :query', query: "%#{query}%")
  end

  def teachings
    Teaching.where(instructor_id: id)
  end

  def sections
    Section.where('uuid IN (?)', teachings.map(&:section_uuid))
  end
end
