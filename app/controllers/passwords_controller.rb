class PasswordsController < ApplicationController
  before_action :login_required


  def show
    redirect_to current_customer
  end

  def edit
    @customer = current_customer
  end

  def update
    @customer = current_customer
    current_password = params[:customer][:current_password]

    if current_password.present?
      if @customer.authenticate(current_password) #現在のパスワードの確認
        @customer.assign_attributes(params.required(:customer).permit([:current_password,:password,:password_confirmation]))
        if @customer.save
          redirect_to @customer, notice: "パスワードを変更しました。"
        else #エラー・パスワード変更に失敗
          render "edit"
        end
      else #エラー・現在のパスワードと不一致
        @customer.errors.add(:current_password, :wrong)
        render "edit"
      end
    else #エラー・パスワード入力欄が空欄
      @customer.errors.add(:current_password, :empty)
      render "edit"
    end
  end
end
