# frozen_string_literal: true

class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  # You should configure your model like this:
  # devise :omniauthable, omniauth_providers: [:twitter]

  # You should also create an action method in this controller like this:
  # def twitter
  # end

  # More info at:
  # https://github.com/heartcombo/devise#omniauth

  # GET|POST /resource/auth/twitter
  # def passthru
  #   super
  # end

  # GET|POST /users/auth/twitter/callback
  # def failure
  #   super
  # end

  byebug
  
  def line; basic_action end

  #def google_oauth2
  #  byebug
  #  callback_for :google_oauth2
  #end

  byebug
  def google_oauth2
    callback_for(:google)
  end

  #byebug
  #def callback_from(provider)
  #  provider = provider.to_s
  #  @user = User.find_for_oauth(request.env['omniauth.auth'])
#
  #  if @user.persisted?
  #    flash[:notice] = I18n.t('devise.omniauth_callbacks.success', kind: provider.capitalize)
  #    sign_in_and_redirect @user, event: :authentication
  #  else
  #    session["devise.#{provider}_data"] = request.env['omniauth.auth']
  #    redirect_to new_user_registration_url
  #  end
  #end

  byebug
  def callback_for(provider)
    # 先ほどuser.rbで記述したメソッド(from_omniauth)をここで使っています
    # 'request.env["omniauth.auth"]'この中にgoogoleアカウントから取得したメールアドレスや、名前と言ったデータが含まれています
    @user = User.from_omniauth(request.env["omniauth.auth"])
    sign_in_and_redirect @user, event: :authentication
    set_flash_message(:notice, :success, kind: "#{provider}".capitalize) if is_navigational_format?
  end

  byebug
  #def callback_for(provider)
  #  @user = User.from_omniauth(request.env["omniauth.auth"])
  #  if @user.persisted?
  #    sign_in_and_redirect @user, event: :authentication #this will throw if @user is not activated
  #    set_flash_message(:notice, :success, kind: "#{provider}".capitalize) if is_navigational_format?
  #  else
  #    session["devise.#{provider}_data"] = request.env["omniauth.auth"].except("extra")
  #    redirect_to new_user_registration_url
  #  end
  #end

  def failure
    redirect_to root_path
  end

  # protected

  # The path used when OmniAuth fails
  # def after_omniauth_failure_path_for(scope)
  #   super(scope)
  # end
  private
  
  byebug
  def basic_action
    @omniauth = request.env["omniauth.auth"]
    if @omniauth.present?
      @profile = User.find_or_initialize_by(provider: @omniauth["provider"], uid: @omniauth["uid"])
      if @profile.email.blank?
        email = @omniauth["info"]["email"] ? @omniauth["info"]["email"] : "#{@omniauth["uid"]}-#{@omniauth["provider"]}@example.com"
        @profile = current_user || User.create!(provider: @omniauth["provider"], uid: @omniauth["uid"], email: email, name: @omniauth["info"]["name"], password: Devise.friendly_token[0, 20])
      end
      @profile.set_values(@omniauth)
      sign_in(:user, @profile)
    end
    flash[:notice] = "ログインしました"
    redirect_to root_path
  end

  def fake_email(uid, provider)
    "#{auth.uid}-#{auth.provider}@example.com"
  end
  
end