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

    #before_actionをコールバックとして使うため
    private def login_required
        raise LoginRequired unless current_customer
    end

    #customer・ログインした本人のページのみ表示・コールバック
    private def id_confirmed_customer
        if params[:id].to_i != current_customer.id
            redirect_to :root,notice: "他のユーザーのマイページは閲覧できません。"
        end 
    end

    #reservation・ログインした本人のページのみ表示・コールバック
    private def id_confirmed_reservation
        if Reservation.find(params[:id]).customer.id != current_customer.id
            redirect_to :root,notice: "他のユーザーの予約情報は閲覧できません。"
        end 
    end

    ###########これ以下、エラー処理の記述
    class LoginRequired < StandardError; end
    class Forbidden < StandardError; end

    #エラーメッセージ・親の方を先に記述する。
    if Rails.env.production? || ENV["RESCUE_EXCEPTIONS"]
        rescue_from StandardError, with: :rescue_internal_server_error
        rescue_from ActiveRecord::RecordNotFound, with: :rescue_not_found
        rescue_from ActionController::ParameterMissing, with: :rescue_bad_request
    end
    rescue_from LoginRequired, with: :rescue_login_required
    rescue_from Forbidden, with: :rescue_forbidden

    #STATUS400・リクエストの不正
    private def rescue_bad_request(exception)
        render "errors/bad_request", status: 400, layout:"error",
            formats: [:html]
    end

    #STATUS403・リソースのアクセス権限の未所持
    private def rescue_login_required(exception)
        render "errors/login_required", status: 403, layout: "error",
            formats: [:html]
    end

    #STATUS403・リソースのアクセス権限の未所持
    private def rescue_forbidden(exception)
        render "errors/forbidden", status: 403, layout: "error",
            formats: [:html]
    end

    #STATUS404・リソースが存在しない。
    private def rescue_not_found(exception)
        render "errors/not_found", status: 404, layout: "error",
            formats: [:html]
    end

    #STATUS500・アプリケーションでエラ
    private def rescue_internal_server_error(exception)
        render "errors/internal_server_error", status: 500, layout: "error",
            formats: [:html]
    end
end
