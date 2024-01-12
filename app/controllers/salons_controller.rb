class SalonsController < ApplicationController
  def index
    @salons = Salon.where(prefecture: params[:prefecture])
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
    current_customer.votes.destroy(Salon.find(params[:id]))
    redirect_to :salons, notice: "削除しました。"
  end


  #投票した記事
  def voted
    if params[:member_id]
      @member = Member.find(params[:member_id])
    else
      @member = current_member
    end
    
    @entries = @member.voted_entries.published
      .order("votes.created_at DESC")
      .page(params[:page]).per(15)
  end
end
