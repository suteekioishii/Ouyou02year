class ApplicationController < ActionController::Base
    #カスタマー用・ログイン判断
    private def current_customer
        Customer.find_by(id: cookies.signed[:customer_id]) if cookies.signed[:customer_id]
    end
    helper_method :current_customer

    #管理者用・ログイン判断
    private def current_admin
        Administrator.find_by(id: cookies.signed[:admin_id]) if cookies.signed[:admin_id]
    end
    helper_method :current_admin

    #オーナー用・ログイン判断
    private def current_owner
        Owner.find_by(id: cookies.signed[:owner_id]) if cookies.signed[:owner_id]
    end
    helper_method :current_owner
end
