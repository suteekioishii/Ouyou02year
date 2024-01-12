class Owner::StylistsController < Owner::Base
  def index
    @salon = current_owner.salon
    @stylists = @salon.stylists
  end

  def show
    @stylist = Stylist.find(params[:id])
    @salon = @stylist.salon
  end
end
