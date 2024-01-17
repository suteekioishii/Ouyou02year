class Owner::ShiftsController < Owner::Base
  before_action :owner_login_required

  def new
    @stylist_id = params[:stylist_id]
    @stylist = Stylist.find(@stylist_id)
    @salon = @stylist.salon.id
  end

  def destroy_index
    @stylist_id = params[:stylist_id]
    @stylist = Stylist.find(@stylist_id)
    @salon = @stylist.salon.id

    #destroyアクションに遷移するためだけにレコードを取り出す。
    #該当レコードを持たずにdestroyアクションに行く方法が分からない。
    @shift = Shift.first
  end

  def create
    #必要データの取得(エラーが絶対起きない、hidden_fieldのデータ)
    @salon = Salon.find(params[:salon_id])
    @stylist = Stylist.find(params[:stylist_id])

    if not params[:add_date].nil?
      @add_dates = params[:add_date]
      #シフトの追加
      @add_dates.each do |add_date|
        add_date = DateTime.parse(add_date)
        #シフトの重複追加防止
        unless exists_shift(add_date,@stylist,1)
          @shift = shift_create(@stylist,add_date)
          unless @shift.save!
            redirect_to [:new, :owner, @stylist,:shift],notice: "シフトの保存中にエラーが発生しました。"
          end
        end
      end
      redirect_to [:new, :owner, @stylist,:shift],notice: "シフトの変更が正常に行われました。"
    else
      redirect_to [:new, :owner, @stylist,:shift],notice: "一つも選択されていません。"
    end
  end

  def destroy
    @end_message = "シフトの変更が正常に行われました。"
    #必要データの取得(エラーが絶対起きない、hidden_fieldのデータ)
    @salon = Salon.find(params[:salon_id])
    @stylist = Stylist.find(params[:stylist_id])

    if not params[:delete_date].nil?
      @delete_dates = params[:delete_date]
      #シフトの削除
      @delete_dates.each do |destroy_date|
        destroy_date = DateTime.parse(destroy_date)
        #シフトの重複追加防止
        if exists_shift(destroy_date,@stylist,1)
          @shift = Shift.find_by(date_time: destroy_date,stylist_id: @stylist.id)
          #予約されているシフトは消せない
          if @shift.reservation.nil?
            @shift.destroy
          else
            @end_message = "一部シフトは予約されており削除できませんでした。\n"
          end
        else
          @end_message += "存在していないシフトが選択されました。"
        end
      end
      redirect_to [:destroy_index, :owner, @stylist,:shifts],notice: @end_message
    else
      redirect_to [:destroy_index, :owner, @stylist,:shifts],notice: "一つも選択されていません。"
    end
  end

  #シフト作成用メソッド
  def shift_create(stylist,add_time)
    attrs = [
      :stylist_id,
      :date_time,
  ]
    @data = {
      stylist_id: stylist.id,
      date_time: add_time
}
    shift = Shift.new(@data)
    return shift
  end
end
