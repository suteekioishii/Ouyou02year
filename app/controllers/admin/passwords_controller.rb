class Admin::PasswordsController < Admin::Base
  before_action :admin_login_required

  def show
    redirect_to current_admin
  end

  def edit
    @admin = current_admin
  end

  def update
    @admin = current_admin
    current_password = params[:administrator][:current_password]

    if current_password.present?
      if @admin.authenticate(current_password) #現在のパスワードの確認
        @admin.assign_attributes(params.required(:administrator).permit([:current_password,:password,:password_confirmation]))
        if @admin.save
          redirect_to [:admin,@admin] , notice: "パスワードを変更しました。"
        else #エラー・パスワード変更に失敗
          render "edit"
        end
      else #エラー・現在のパスワードと不一致
        @admin.errors.add(:current_password, :wrong)
        render "edit"
      end
    else #エラー・パスワード入力欄が空欄
      @admin.errors.add(:current_password, :empty)
      render "edit"
    end
  end
end
