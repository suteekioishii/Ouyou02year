class Customer < ApplicationRecord
    #関連付け
    has_secure_password
    has_many :reservations, dependent: :nullify
    has_many :votes, dependent: :nullify

    #バリデーション
    #名前
    validates :name, presence: true,
        length: { maximum: 10, allow_blank: true }
    validates :email, email: {allow_blank: true}
    validates :phone, presence: true,
        format: { with:/\A\(?[0-9]*\)?-?[0-9]*-?[0-9]*\z/,allow_blank: true },
        length: { minimum: 10, maximum: 15, allow_blank: true },
        uniqueness: { case_sensitive: false}
    validates :birthday, comparison:{ less_than: Time.current.to_date }
    
    #パスワード
    attr_accessor :current_password
    validates :password, presence: { if: :current_password}
end
