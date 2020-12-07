class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_q

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[name nickname])
    devise_parameter_sanitizer.permit(:account_update,
                                      keys: %i[name nickname avatar avatar_cache remove_avatar])
  end

  def set_q
    @q = User.ransack(params[:q])
  end
end
