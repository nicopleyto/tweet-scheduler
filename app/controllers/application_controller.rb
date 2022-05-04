class ApplicationController < ActionController::Base
    before_action :authenticate_user!
    before_action :configure_permitted_parameters, if: :devise_controller?
    around_action :set_time_zone, if: :current_user

    protected

    def configure_permitted_parameters
        devise_parameter_sanitizer.permit(:sign_up, keys: [:time_zone])
        devise_parameter_sanitizer.permit(:account_update, keys: [:time_zone])
    end

    def set_time_zone(&block)
        Time.use_zone(current_user.time_zone, &block)
    end
end
