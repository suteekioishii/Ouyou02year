class ReservationsController < ApplicationController
  def index
  end

  def show
    @reservation = Reservation.find(params[:id])
  end

  #予約可能時間を表で表示。
  def new
    #reservationの新規レコードの作成
    @reservation = Reservation.new
    #コース別の必要時間の取得
    @required_time = Course.find_by(id: params[:reserved_course]).required_time
    #styilst.idを送る
    @stylist_id = params[:reserved_stylist]
    #course.idを送る
    @course_id = params[:reserved_course]
    #予約可能時間表を表示するためのshit
    @shifts = Shift.all
    #スタイリスト検索・"指定なし"がありの場合
    if not params[:course_free].to_i
      @stylist_name = "指定なし"
    else
      @shifts.where(stylist_id: params[:reserved_course].to_i) 
      @stylist_name = Stylist.find(@stylist_id).name
    end
    #コース検索
    if not params[:stylist_free].to_i
      @course_name = "指定なし"
    else
      @shifts.where(stylist_id: params[:reserved_stylist].to_i)
      @course_name = Course.find(@course_id).name
    end
    @salon = Salon.find_by(id: params[:salon_id])
    #予約情報の取得
    @sum_price = Course.find_by(id: @course_id).price
  end
  
  def create
    #ログインしている場合
    if current_customer
      #reservationを登録する。
      @salon = Salon.find_by(id: params[:salon_id])
      @reservation = Reservation.new(reservation_params)
      @reservation.customer_id = current_customer.id
      if @reservation.save!
        #shiftを占有する。
        @count = params[:reservation][:reserved_time].to_i
        @stylist = params[:stylist_id].to_i
        @base_date = DateTime.parse(params[:reservation][:reserved_date])
        #shiftを実際に取り出す
        for count in 0..@count-1
          @shift_date = @base_date.since(30.minutes*count)
          @shift = Shift.find_by(date_time: @shift_date,stylist_id: @stylist)
          redirect_to @salon if not @shift.update_attribute(:reservation_id,@reservation.id)
        end
          redirect_to @reservation,notice: "予約しました。"
      else
          redirect_to @salon
      end
    else #ログインしていない場合
      #session[:reservation] = reservation_params
      redirect_to new_customer_path, notice: "ログインを行なって下さい"
    end
    
  end

  # ストロング・パラメータ
  private def reservation_params
    attrs = [
        :reserved_date,
        :reserved_time,
        :sum_price,
        :course_id
    ]
    params.require(:reservation).permit(attrs)
  end
end
