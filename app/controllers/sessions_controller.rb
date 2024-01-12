class SessionsController < ApplicationController
    def show
    end

    #ログイン
    def create
        customer =  Customer.find_by(name: params[:name])

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
    end

    def destroy
        cookies.delete(:customer_id)
        redirect_to :root
    end
end
