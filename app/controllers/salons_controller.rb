class SalonsController < ApplicationController
  def index
    @salons = Salon.where(prefecture: params[:prefecture])
  end

  def show
  end
end
