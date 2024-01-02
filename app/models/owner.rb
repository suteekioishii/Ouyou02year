class Owner < ApplicationRecord
    has_secure_password
    belongs_to :salon
end
