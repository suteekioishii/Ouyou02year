class Owner::OwnersController < Owner::Base
  before_action :owner_login_required
  before_action :id_confirmed_owner,only: [:show,:edit,:update]

  def show
    @owner = Owner.find(params[:id])
  end

  def update
    @owner = Owner.find(params[:id])
    @owner.assign_attributes(owner_params)
    if @owner.save
      redirect_to [:owner,@owner], notice: "オーナー情報を更新しました。"
    else
      render "edit"
    end
  end

  def edit
    @owner = Owner.find(params[:id])
  end

  #カスタマーのストロングパラ3メータ
  private def owner_params
    attrs = [
      :name,
      :email,
      :phone,
      :sex,
      :birthday
    ]
    attrs << :password if action_name == "create"
    params.required(:owner).permit(attrs)
  end
end
