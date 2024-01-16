class Admin::AdministratorsController < Admin::Base
  before_action :admin_login_required
  def show
    @admin = Administrator.find(params[:id])
  end

  def update
    @admin = Administrator.find(params[:id])
    @admin.assign_attributes(admin_params)
    if @admin.save
      redirect_to [:admin,@admin], notice: "オーナー情報を更新しました。"
    else
      render "edit"
    end
  end

  def edit
    @admin = Administrator.find(params[:id])
  end


  #カスタマーのストロングパラ3メータ
  private def admin_params
    attrs = [
      :name,
      :email,
      :phone,
      :sex,
      :birthday
    ]
    attrs << :password if action_name == "create"
    params.required(:administrator).permit(attrs)
  end
end
