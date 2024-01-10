class Customer < ApplicationRecord
    #関連付け
    has_secure_password
    has_many :reservations, dependent: :nullify
    has_many :votes, dependent: :nullify

    #バリデーション
    #名前
    validates :name, presence: true,
        length: { maximum: 10, allow_blank: true },
        uniqueness: { case_sensitive: false}
end
