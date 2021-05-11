class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  private

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up,
      keys: [:name, :email, :uid, :occupation_id, :workplace_id, :group_id])

    devise_parameter_sanitizer.permit(:sign_in, keys: [:uid])
  end
end
