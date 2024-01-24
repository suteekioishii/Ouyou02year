class ReservationsController < ApplicationController
  before_action :login_required, only: [:create,:index,:show, :destroy]
  before_action :id_confirmed_reservation, only: [:show]
  def index
  end

  def show
    @reservation = Reservation.find(params[:id])
  end

  #予約可能時間を表で表示。
  def new
    #基準時刻の設定
    if not params["base_date(1i)"].nil?
      @now = DateTime.now()
      @year  = params["base_date(1i)"].to_i
      @month = params["base_date(2i)"].to_i
      @day   = params["base_date(3i)"].to_i
      @default_date = DateTime.new(@year,@month,@day,0,0,0).ago(3.days)
      @default_date = DateTime.now if @now.year > @year
      @default_date = DateTime.now if @now.month > @month
      @default_date = DateTime.now if @now.day > @day and @now.month >= @month
    else
      @default_date = DateTime.now
    end
    @default_date = @default_date.since(1.days)

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
    #選択されていない場合
    if not params[:reservation][:reserved_date].nil?
      ##################
      #####必要データの取得
      @salon = Salon.find_by(id: params[:salon_id])
      @reservation = Reservation.new(reservation_params)
      @reservation.customer_id = current_customer.id
      @count = params[:reservation][:reserved_time].to_i
      @stylist = params[:stylist_id].to_i
      @base_date = DateTime.parse(params[:reservation][:reserved_date])

      #同時予約防止のための条件分岐
      if possible_shift(@base_date,@stylist,@count)   
        if @reservation.save!
          #shiftを占有する。
          #shiftを実際に取り出す
          for count in 0..@count-1
            @shift_date = @base_date.since(30.minutes*count)
            @shift = Shift.find_by(date_time: @shift_date,stylist_id: @stylist)
            redirect_to @salon if not @shift.update_attribute(:reservation_id,@reservation.id)
          end
            redirect_to @reservation,notice: "予約しました。"
        else
          redirect_to @salon, notice: "予約情報が保存できませんでした。" 
        end
      else
          @salon = Salon.find_by(id: params[:salon_id])
          redirect_to @salon, notice: "希望の時間帯が既に予約されています。" 
      end
      
    else #ログインしていない場合
      #session[:reservation] = reservation_params
      @salon = Salon.find_by(id: params[:salon_id])
      redirect_to @salon,notice: "希望の時間帯が未選択です。" 
    end
  end

  def destroy
    @reservation = Reservation.find_by(id: params[:id].to_i)
    @shifts = @reservation.shifts
    @reservation.destroy
    redirect_to :reservations, notice: "予約を削除しました。"
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
