class Vote < ApplicationRecord
    belongs_to :customer
    belongs_to :salon
end
