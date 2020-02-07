# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController

  def new
  end

  def create
    @user = User.find_by(sign_in_params)
    if @user.present?
      bypass_sign_in(@user)
     redirect_to my_page_path
    #  , notice: 'ログインに成功しました'
    else 
    #  flash.now[:alert] = 'メールアドレスとパスワードの組み合わせが一致しません'
     render :new
    end
  end

  def destroy
    @user = User.find(current_user.id) # current_userにする
    @user.destroy
    redirect_to root_path
  end

  protected

  def sign_in_params
    params.require(:user).permit(:email, :password, :encrypted_password)
  end

 
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
