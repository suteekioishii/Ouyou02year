class SalonsController < ApplicationController
  def index
    @salons = Salon.where(prefecture: params[:prefecture])
  end

  def show
    @salon = Salon.find(params[:id])
  end
end
