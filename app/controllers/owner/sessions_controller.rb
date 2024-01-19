class Owner::SessionsController < Owner::Base
    def show
    end

    #ログイン
    def create
        owner =  Owner.find_by(name: params[:name])
        if not (cookies.signed[:admin_id] or cookies.signed[:customer_id])
        if owner&.authenticate(params[:password])
            cookies.signed[:owner_id] = {
                value: owner.id,
                expires: 6000.seconds.from_now
            }
            flash.notice = "ログインに成功しました。"
            redirect_to [:owner,:stylists]
        else
            flash.alert = "名前とパスワードが一致しません"
            redirect_to :owner_root
        end
        else
           flash.alert = "ログアウトしてください."
           redirect_to :owner_root
        end
    end

    def destroy
        cookies.delete(:owner_id)
        redirect_to :root
    end
end
