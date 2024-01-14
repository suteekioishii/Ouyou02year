class Owner::StylistsController < Owner::Base
  before_action :owner_login_required
  before_action :owner_stylist_allowed, only: :show
  
  def index
    @salon = current_owner.salon
    @stylists = @salon.stylists
  end

  def show
    @stylist = Stylist.find(params[:id])
    @salon = @stylist.salon
  end
end
