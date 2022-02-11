# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  #before_action :configure_sign_up_params, only: [:create]
  before_action :configure_account_update_params, only: [:update]

  # GET /resource/sign_up
  # def new
  #   super
  # end

  # POST /resource
  def create
    super
    #@user.image = "default_user_image.png"
    resource.build_profile
    #resource.profile.name = resource.username
    if resource.save
      flash[:notice] = "登録したメールアドレスに確認メールを送信しました。メールアドレスをご確認ください。"
    end
  end

  # GET /resource/edit
  # def edit
  #   super
  # end

  # PUT /resource
  # def update
  #   super
  # end
  #def update
  #  current_user.update(account_update_params)
  #  redirect_to user_path(current_user)
  #end

  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_up_params
  #   devise_parameter_sanitizer.permit(:sign_up, keys: [:attribute])
  # end

  # If you have extra params to permit, append them to the sanitizer.
  def configure_account_update_params
    #devise_parameter_sanitizer.permit(:account_update, keys: [:attribute])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name, :birth, :image, :email, :tel, :gender, :postal_code, :prefecture_code, :city, :street, :station_id, :company_id, :line_id, :station, :ward_id, :id_front_image, :id_back_image])
  end

  # ユーザー編集
  def update_resource(resource, params)
    resource.update_without_current_password(params)
  end

  # The path used after sign up.
  def after_sign_up_path_for(resource)
    #super(resource)
    edit_user_registration_path
  end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end
end
