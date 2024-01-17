class Stylist < ApplicationRecord
    has_many :shifts, dependent: :nullify
    belongs_to :salon

    #バリデーション
    validates :name, presence: true,
        length: { maximum: 11, allow_blank: true }
end
