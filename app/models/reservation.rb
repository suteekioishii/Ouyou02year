class Reservation < ApplicationRecord

    # ストロング・パラメータ
    private def reservation_params
        attrs = [
            :reserved_date,
            :reserved_time,
            :sum_price,
            :cource_id
        ]
        params.require(:reservation).permit(attrs)
    end
end
