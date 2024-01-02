class ReservationsController < ApplicationController
  def index
  end

  def show
  end

  def new
    @reservation = Reservation.new
    @shifts = Shift.all
  end
  
  def create
    #ログインしている場合
    if current_customer
      @reservation = Reservation.new(reservation_params)
      @reservation.reserved_time = Time.new
      @reservation.sum_price = 1
      @reservation.cource_id = 200
      @reservation.customer_id = cookies.signed[:customer_id]
      render reservation_shifts_path(@reservation)
      if @reservation.save
          redirect_to @reservation,notice: "予約しました。"
      else
          render "new"
      end
    else #ログインしていない場合
      session[:reservation] = reservation_params
      redirect_to login_reservation_customers_path,notice: "ログインを行なって下さい"
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
