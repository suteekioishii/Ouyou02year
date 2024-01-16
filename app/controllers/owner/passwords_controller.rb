class Owner::PasswordsController < Owner::Base
  before_action :owner_login_required

  def show
    redirect_to current_owner
  end

  def edit
    @owner = current_owner
  end

  def update
    @owner = current_owner
    current_password = params[:owner][:current_password]

    if current_password.present?
      if @owner.authenticate(current_password) #現在のパスワードの確認
        @owner.assign_attributes(params.required(:owner).permit([:current_password,:password,:password_confirmation]))
        if @owner.save
          redirect_to [:owner,@owner], notice: "パスワードを変更しました。"
        else #エラー・パスワード変更に失敗
          render "edit"
        end
      else #エラー・現在のパスワードと不一致
        @owner.errors.add(:current_password, :wrong)
        render "edit"
      end
    else #エラー・パスワード入力欄が空欄
      @owner.errors.add(:current_password, :empty)
      render "edit"
    end
  end
end
