class SalonsController < ApplicationController
  def index
    if params[:prefecture] == "指定なし"
      @salons = Salon.all
    else
      @salons = Salon.where(prefecture: params[:prefecture])
    end
    @q = params[:q]
    if @q
      @salons = @salons.where("name LIKE ?", "%#{@q}%")
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
