class Admin::SalonsController < Admin::Base
  def index
    if params[:prefecture] == "指定なし"
      @salons = Salon.all
    else
      @salons = Salon.where(prefecture: params[:prefecture])
    end
  end

  def show
    @salon = Salon.find(params[:id])
  end

  def new 
    @salon = Salon.new
  end

  def create
    @salon = Salon.new(salon_params)
    if @salon.save
      redirect_to [:admin,@salon], notice: "新規登録が完了しました。"
    else
      render "new"
    end    
  end

  def update
    @salon = Salon.find(params[:id])
    @salon.assign_attributes(salon_params)
    if @salon.save
      redirect_to [:admin,@salon], notice: "美容院情報を更新しました。"
    else
      render "edit"
    end
  end

  def edit
    @salon = Salon.find(params[:id])
  end

  def destroy
    @salon = Salon.find(params[:id])
    @name = @salon.name
    @salon.destroy
    redirect_to :salons, notice: "#{@name}を削除しました。"
  end

  # ストロング・パラメータ
  private def salon_params
    attrs = [
      :name,
      :prefecture,
      :adress
    ]
    params.require(:salon).permit(attrs)
  end
end
