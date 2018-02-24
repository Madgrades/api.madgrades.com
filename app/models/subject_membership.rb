class SubjectMembership < ApplicationRecord
  default_scope { order(subject_code: :asc) }
end
