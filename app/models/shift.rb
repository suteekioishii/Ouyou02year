class Shift < ApplicationRecord
    belongs_to :reservation, optional: true
    belongs_to :stylist
end