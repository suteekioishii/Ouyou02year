class Course < ApplicationRecord
    has_many :reservations, dependent: :nullify
end
