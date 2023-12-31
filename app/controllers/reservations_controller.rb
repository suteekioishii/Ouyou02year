class ReservationsController < ApplicationController
  def index
  end

  def show
  end

  def new
    @reservation = Reservation.new
  end
  
  def create
    #ログインしている場合
    if current_customer
      @reservation = Reservation.new(reservation_params)
      if @reservation.save
          redirect_to @reservation,notice: "会員を登録しました。"
      else
          render "new"
      end
    else #ログインしていない場合
      session[:reservation] = reservation_params
    end
    
  end

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
