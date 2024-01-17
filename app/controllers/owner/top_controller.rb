class Owner::TopController < Owner::Base
    def index
        if current_owner
            redirect_to [:owner,:stylists],notice: "既にログインしているためスタイリスト一覧を表示します。"
        end
    end
end
