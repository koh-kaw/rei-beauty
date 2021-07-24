class ApplicationController < ActionController::Base

    before_action :configure_permitted_parameters, if: :devise_controller?
    protect_from_forgery with: :exception
  
    protected
  
    def configure_permitted_parameters
      #条件分岐（User or Business user）
      devise_parameter_sanitizer.permit(:sign_up, keys: %i(name sex image image_cache family_name first_name family_name_kana first_name_kana tel station category birth))
    end

    private

    # ログイン後のリダイレクト先
    def after_sign_in_path_for(resource_or_scope)
      if resource_or_scope.is_a?(BusinessUser)
        buser_mypage_path
      else
        mypage_path
      end
    end
  
    # ログアウト後のリダイレクト先
    def after_sign_out_path_for(resource_or_scope)
      if resource_or_scope == :business_user
        new_business_user_session_path
      else
        new_user_session_path
      end
    end

end
