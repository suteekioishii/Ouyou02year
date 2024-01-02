class Stylist < ApplicationRecord
    has_many :shifts, dependent: :nullify
    belongs_to :salon
end
