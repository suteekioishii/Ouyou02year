class Owner::Base < ApplicationController
    #before_action :owner_login_required

    #管理者を判断するコールバック
    private def owner_login_required
        raise Forbidden unless current_owner
    end
end