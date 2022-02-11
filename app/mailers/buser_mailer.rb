class BuserMailer < ApplicationMailer
    def service_done_mail
        @user = params[:user]
        @business_user = params[:business_user]
        mail(to: @business_user.email, subject: '施術完了のお知らせ')
        mail(to: @user.email, subject: '施術完了のお知らせ')
    end

end
