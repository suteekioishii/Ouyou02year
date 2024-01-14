class Owner::Base < ApplicationController
    #before_action :owner_login_required


    #######コールバック
    #管理者を判断する
    private def owner_login_required
        raise Forbidden unless current_owner
    end

    #他店のスタイリストの詳細は見せない。
    private def owner_stylist_allowed
        unless current_owner.salon.stylists.exists?(id: params[:id])
            redirect_to [:owner,:stylists], notice: "他店のスタイシスト詳細は表示できません。"
        end
    end
end