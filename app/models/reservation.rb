class Reservation < ApplicationRecord
    belongs_to :customer
    belongs_to :course
    has_many :shifts, dependent: :nullify
    
end
