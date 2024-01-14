class Salon < ApplicationRecord
    has_many :owners, dependent: :destroy
    has_many :stylists, dependent: :destroy
    has_many :votes, dependent: :destroy
    has_many :customers, through: :votes

    #バリデーション
    validates :name, presence: true,
        length: { maximum: 11, allow_blank: true }
    validates :adress, presence: true

    @@prefecture = ["指定なし","北海道","青森県","岩手県","宮城県","秋田県","山形県","福島県","茨城県","栃木県","群馬県","埼玉県","千葉県","東京都","神奈川県","新潟県","富山県","石川県","福井県","山梨県","長野県","岐阜県","静岡県","愛知県","三重県","滋賀県","京都府","大阪府","兵庫県","奈良県","和歌山県","鳥取県","島根県","岡山県","広島県","山口県","徳島県","香川県","愛媛県","高知県","福岡県","佐賀県","長崎県","熊本県","大分県","宮崎県","鹿児島県","沖縄県"]
    class << self
        def search(query,sex)
            rel = order("number")
            if query.present?
                rel = rel.where("name LIKE ? OR full_name LIKE ?","%#{query}%", "%#{query}%")
                #指定なしが選択された場合。
                if sex != 3
                  rel = rel.where(sex: sex)
                end
            end
            rel
        end


        def prefecture
            @@prefecture
        end
    end
end
