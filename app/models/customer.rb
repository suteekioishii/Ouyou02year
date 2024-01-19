class Customer < ApplicationRecord
    #関連付け
    has_secure_password
    has_many :reservations, dependent: :nullify
    has_many :votes, dependent: :destroy
    has_many :salons, through: :votes

    #バリデーション
    validates :name, presence: true,
        length: { maximum: 10, allow_blank: true },
        uniqueness: { case_sensitive: false}
    validates :email, email: {allow_blank: true}
    validates :phone, presence: true,
        format: { with:/\A\(?[0-9]*\)?-?[0-9]*-?[0-9]*\z/,allow_blank: true },
        length: { minimum: 9, maximum: 19, allow_blank: true },
        uniqueness: { case_sensitive: false}
    validates :birthday, comparison:{ less_than: Time.current.to_date }
    
    #パスワード
    attr_accessor :current_password
    validates :password, presence: { if: :current_password},
    format: { with:/\A[a-zA-Z0-9!]*\z/,allow_blank: true },
    length: { minimum: 7, maximum: 20, allow_blank: true }

    #いいねのルール・一つのお店につき一回のみ投票できる。
    def votable_for?(salon)
        salon  && !votes.exists?(salon_id: salon.id)
    end
end
