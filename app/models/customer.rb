class Customer < ApplicationRecord
    has_secure_password
    has_many :reservations, dependent: :nullify
end
