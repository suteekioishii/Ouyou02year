class Admin::Base < ApplicationController
    #before_action :admin_login_required

    #管理者を判断するコールバック
    private def admin_login_required
        raise Forbidden unless current_admin
    end
end