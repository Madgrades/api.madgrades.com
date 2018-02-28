class Subject < ApplicationRecord
  self.primary_key = :code

  default_scope { order(code: :asc) }

  def to_param
    code
  end
end
