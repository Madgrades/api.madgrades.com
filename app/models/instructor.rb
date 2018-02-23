class Instructor < ApplicationRecord
  self.primary_key = :id

  def teachings
    Teaching.where(instructor_id: id)
  end

  def sections
    Section.where('uuid IN (?)', teachings.map(&:section_uuid))
  end
end
