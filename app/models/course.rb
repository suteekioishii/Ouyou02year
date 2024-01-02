class Course < ApplicationRecord
    has_many :course, dependent: :nullify
end
