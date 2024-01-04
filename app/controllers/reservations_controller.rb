class ReservationsController < ApplicationController
  def index
  end

  def show
  end

  #予約可能時間を表で表示。
  def new
    #reservationの新規レコードの作成
    @reservation = Reservation.new
    #コース別の必要時間の取得
    @count = Course.find(params[:reserved_course]).required_time
    #予約可能時間表を表示するためのshiftRBを取得
    @shifts = Shift.where(stylist_id: params[:reserved_stylist].to_i).where(course_id: params[:reserved_course].to_i)
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
