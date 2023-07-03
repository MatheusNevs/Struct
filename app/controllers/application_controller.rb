class ApplicationController < ActionController::API
    def is_admin_authentication
        unless current_user.is_admin
            render json: "Você precisa ser um administrador para efetuar essa ação", status: :unauthorized
        end
    end
end
