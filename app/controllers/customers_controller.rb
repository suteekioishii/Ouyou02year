class CustomersController < ApplicationController
  before_action :login_required,only: [:show,:edit,:update,:destroy]
  before_action :id_confirmed_customer, only: [:show,:edit,:update,:destroy]

  def new
    @customer = Customer.new
  end

  def create
    @customer = Customer.new(customer_params)
    if @customer.save
      redirect_to "/", notice: "新規登録が完了しました。"
    else
      render "new"
    end
  end

  def update
    @customer = Customer.find(params[:id])
    @customer.assign_attributes(customer_params)
    if @customer.save
      redirect_to @customer, notice: "会員情報を更新しました。"
    else
      render "edit"
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
    if @customer.reservations.count == 0
      @customer.destroy
      redirect_to :root, notice: "ユーザー#{@name}を削除しました"
    else
      redirect_to @customer, notice: "予約情報を持っているため削除できません。"
    end
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
