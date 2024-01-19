class SessionsController < ApplicationController
    def show
    end

    #ログイン
    def create
        customer =  Customer.find_by(name: params[:name])
        if not (cookies.signed[:admin_id] or cookies.signed[:owner_id])
        if customer&.authenticate(params[:password])
            cookies.signed[:customer_id] = {
                value: customer.id,
                expires: 6000.seconds.from_now
            }
            flash.notice = "ログインに成功しました。"
            redirect_to :root
        else
            flash.alert = "名前とパスワードが一致しません"
            redirect_to :root
        end
        else
           flash.alert = "ログアウトしてください."
           redirect_to :root
        end
    end

    def destroy
        cookies.delete(:customer_id)
        redirect_to :root
    end
end
