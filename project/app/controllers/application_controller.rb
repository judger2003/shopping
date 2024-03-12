class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  protect_from_forgery with: :exception, unless: -> { request.format.js? }
  def after_sign_in_path_for(resource)
    if current_user.has_role?(:god)
    products_path
    else
      products_read_path
    end
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:username, :phone_number])
    devise_parameter_sanitizer.permit(:account_update, keys: [:username, :phone_number])
  end
  def after_update_path_for(resource)
    if current_user.has_role?(:god)
      products_path
    else
      products_read_path
    end
  end
end
