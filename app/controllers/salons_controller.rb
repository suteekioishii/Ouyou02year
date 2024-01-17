class SalonsController < ApplicationController
  def index
    #都道府県・検索
    if params[:prefecture] == "全検索"
      @salons = Salon.all
    else
      @salons = Salon.where(prefecture: params[:prefecture])
    end
    #美容院・検索
    @q = params[:q]
    if @q
      @salons = @salons.where("name LIKE ?", "%#{@q}%")
    end
    #スタイリスト検索
    @stylist = params[:stylist_name]
    unless @stylist_free
      @salons = @salons.where(id: @stylist)
    end
  end

  def show
    @salon = Salon.find(params[:id])
  end

  #いいね登録
  def like
    @salon = Salon.find(params[:id])
    current_customer.salons << @salon
    redirect_to @salon, notice: "投票しました"
  rescue
    redirect_to @salon
  end

  #いいね削除
  def unlike
    current_customer.salons.destroy(Salon.find(params[:id]))
    redirect_to current_customer, notice: "削除しました。"
  end
end
