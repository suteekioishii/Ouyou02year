class Admin::SalonsController < Admin::Base
  before_action :admin_login_required

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
    @stylist = params[:salon_id]
    unless params[:stylist_free]
      @salons = @salons.where(id: @stylist)
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
    if @salon.stylists.count == 0
      @salon.destroy
      redirect_to [:admin,:salons], notice: "#{@name}を削除しました。"
    else
      redirect_to [:admin,@salon], notice: "#{@name}にはスタイリストが在籍しています。"
    end

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
