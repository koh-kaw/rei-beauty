class UserMailer < ApplicationMailer
    def reserve_mail
        @user = params[:user]
        mail(to: @user.email, subject: '予約確定のお知らせ')
    end

    def cancel_mail
      @user = params[:user]
      mail(to: @user.email, subject: '予約キャンセルのお知らせ')
    end

    def chat_mail
      @user = params[:user]
      @buser = params[:business_user]
      mail(to: @user.email, subject: '新着チャットがあります')
      mail(to: @buser.email, subject: '新着チャットがあります')
    end

    def new_buser_mail
      @buser = params[:business_user]
      mail(to: 'rei.beauty.test@gmail.com', subject: '新規面接登録のお知らせ')
    end

    def service_done_mail
      @user = params[:user]
      #@business_user = params[:business_user]
      #mail(to: @business_user.email, subject: '施術完了のお知らせ')
      mail(to: @user.email, subject: '施術完了のお知らせ')
  end
end
