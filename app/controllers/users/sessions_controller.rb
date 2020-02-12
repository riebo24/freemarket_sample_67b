# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  before_action :configure_permitted_parameters, only: [:create]

  def new
  end

  def create
    if user = User.authentication_keys(params[:email], params[:password])
      session[:user_id] = user.id
　　   else
      render ‘create’
    end
  end

  def destroy
    @user = User.find(current_user.id) 
    @user.destroy
    redirect_to root_path
  end

  protected

  # def sign_in_params
  #   params.require(:session).permit(:email, :encrypted_password)
  # end

 
  def after_sign_in_path_for(resource)
    my_page_path
  end

  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
