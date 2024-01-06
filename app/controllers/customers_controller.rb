class CustomersController < ApplicationController
  def index
  end

  def new
    @customer = Customer.new
  end

  def create
    @customer = Customer.new(params[:customer])
    if @customer.save
      redirect_to @customer, notice: "新規登録が完了しました。"
    end
  end

  def show
  end
  
  def login
  end

  #カスタマーのストロングパラメータ
  private def customer_params
    attrs = [
      :name,
      :email,
      :phone,
      :sex,
      :birthday
    ]
    attrs << :password if action_name == "create"
    params.required(:customer).permit(attrs)
  end
end
