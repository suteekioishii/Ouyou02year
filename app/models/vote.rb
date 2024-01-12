class Vote < ApplicationRecord
    belongs_to :customer
    belongs_to :salon

    validate do
        #いいねルールに合わない場合は保存できない。
        unless customer && customer.votable_for?(salon)
            errors.ad(:base, :invalid)
        end
    end
end
