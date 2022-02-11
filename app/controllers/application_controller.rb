class ApplicationController < ActionController::Base

    before_action :configure_permitted_parameters, if: :devise_controller?
    before_action :configure_account_update_parameters, if: :devise_controller?

    protect_from_forgery with: :exception
    
    before_action :get_categories
    
    def get_categories
      @categories=Category.all
    end


    protected
  
    # ユーザー登録時の項目
    def configure_permitted_parameters
      #条件分岐（User or Business user）
      devise_parameter_sanitizer.permit(:sign_up, keys: %i(name gender image image_cache family_name first_name family_name_kana first_name_kana tel station category birth avatar agreement emergency_contact emergency_name remove_image id_front_image id_back_image bank_type bank_account_number bank_name bank_username ))
    end
    # ユーザー編集時の項目
    def configure_account_update_parameters
      devise_parameter_sanitizer.permit(:account_update, keys: %i(name image family_name first_name family_name_kana first_name_kana tel station ward_id remove_image id_front_image id_back_image bank_type bank_account_number bank_name bank_username ))
    end

    private

    # ログイン後のリダイレクト先
    def after_sign_in_path_for(resource_or_scope)
      if resource_or_scope.is_a?(BusinessUser)
        buser_mypage_path
      else
        # 初回ログイン時のみユーザー設定画面に飛ばす
        #if current_user.sign_in_count.zero?
        #  edit_user_registration_path
        #else
          mypage_path
        #end
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
