class ApplicationController < ActionController::Base
  before_action :basic_auth, if: :production?
  before_action :configure_permitted_parameters, if: :devise_controller?
  # before_action :authenticate_user! 
  protect_from_forgery with: :exception

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, 
      keys: [:nickname, :first_name, :last_name, :first_kane, :last_kane, :post_number, :prefecture, :city, :house_number, :building_name, :phone_number, :birthday, :card, :profile])
    devise_parameter_sanitizer.permit(:sign_in, keys: [:email, :passwaord])
  end

  def production?
    Rails.env.production?
  end

  def basic_auth
    authenticate_or_request_with_http_basic do |username, password|
      username == ENV["BASIC_AUTH_USER"] && password == ENV["BASIC_AUTH_PASSWORD"]
    end
  end
end

