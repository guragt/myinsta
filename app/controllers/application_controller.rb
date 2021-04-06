class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_q

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[name nickname])
  end

  def set_q
    @q = User.ransack(params[:q])
  end

  def after_sign_up_path_for(_resource)
    root_path
  end
end
