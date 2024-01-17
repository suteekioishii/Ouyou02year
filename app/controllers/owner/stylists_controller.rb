class Owner::StylistsController < Owner::Base
  before_action :owner_login_required
  before_action :owner_stylist_allowed, only: :show
  
  def index
    @salon = current_owner.salon
    @stylists = @salon.stylists
  end

  def show
    @stylist = Stylist.find(params[:id])
    @salon = @stylist.salon
  end

  def new 
    @stylist = Stylist.new
  end

  def create
    @stylist = Stylist.new(stylist_params)
    if @stylist.save
      redirect_to [:owner,@stylist], notice: "新規登録が完了しました。"
    else
      render "new"
    end    
  end

  def update
    @stylist =Stylist.find(params[:id])
    @stylist.assign_attributes(stylist_params)
    if @stylist.save
      redirect_to [:owner,@stylist], notice: "スタイリスト情報を更新しました。"
    else
      render "edit"
    end
  end

  def edit
    @stylist = Stylist.find(params[:id])
  end

  def destroy
    @stylist = Stylist.find(params[:id])
    @name = @stylist.name
    if true
      @stylist.destroy
      redirect_to [:owner,:stylists], notice: "#{@name}を削除しました。"
    else
      redirect_to [:owner,@salon], notice: "#{@name}にはスタイリストが在籍しています。"
    end

  end

  # ストロング・パラメータ
  private def stylist_params
    attrs = [
      :name,
      :salon_id
    ]
    params.require(:stylist).permit(attrs)
  end
end
