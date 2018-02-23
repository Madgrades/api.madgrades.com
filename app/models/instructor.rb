class Instructor < ApplicationRecord
  self.primary_key = :id

  default_scope { order(name: :asc) }

  def teachings
    Teaching.where(instructor_id: id)
  end

  def sections
    Section.where('uuid IN (?)', teachings.map(&:section_uuid))
  end
end
