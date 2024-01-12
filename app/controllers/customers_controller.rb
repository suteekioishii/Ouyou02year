class CustomersController < ApplicationController
  def index
  end

  def new
    @customer = Customer.new
  end

  def create
    @customer = Customer.new(customer_params)
    if @customer.save
      redirect_to @customer, notice: "新規登録が完了しました。"
    else
      render "new"
    end
  end

  def show
    @customer = Customer.find(params[:id])
  end

  def edit
    @customer = Customer.find(params[:id])
  end

  def destroy
    @customer = Customer.find(params[:id])
    @name = @customer.name
    @customer.destroy
    redirect_to :root, notice: "ユーザー#{@name}を削除しました"
  end

  def edit
    @customer = Customer.find(params[:id])
  end
  
  def login
  end

  #カスタマーのストロングパラ3メータ
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
