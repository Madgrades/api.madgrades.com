class Room < ApplicationRecord
  self.primary_key = :uuid

  def to_param
    uuid
  end
end
