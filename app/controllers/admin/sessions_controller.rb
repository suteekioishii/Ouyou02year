class Admin::SessionsController < Admin::Base
    def show
    end

    #ログイン
    def create
        admin =  Administrator.find_by(name: params[:name])

        if admin&.authenticate(params[:password])
            cookies.signed[:admin_id] = {
                value: admin.id,
                expires: 6000.seconds.from_now
            }
            flash.notice = "ログインに成功しました。"
            redirect_to [:admin,:salons]
        else
            flash.alert = "名前とパスワードが一致しません"
            redirect_to :admin_root
        end
    end

    def destroy
        cookies.delete(:customer_id)
        redirect_to :root
    end
end
