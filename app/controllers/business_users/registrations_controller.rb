# frozen_string_literal: true

class BusinessUsers::RegistrationsController < Devise::RegistrationsController
  before_action :configure_sign_up_params, only: [:create]
  before_action :configure_account_update_params, only: [:update]

  def index
    @posts = Post.all
    @business_users = BusinessUser.all
  end

  # GET /resource/sign_up
  # def new
  #   super
  # end

  # POST /resource
  def create
     super
     resource.build_buser_profile
     #resource.buser_profile.name = resource.name
     if resource.save
      @admin_user = User.find(1)
      @business_user = resource

      register_categories

      byebug
      @interview_room = InterviewRoom.new
      byebug
      @interview_room.save!
      # user_roomをReI Admin用と申請者用で作る
      byebug
      InterviewRoomRelation.create(user_id: @admin_user.id, business_user_id: @business_user.id, interview_room_id: @interview_room.id)
      #UserRoom.create(business_user_id: @business_user.id, room_id: @room.id)
      byebug
      @interview_chats = @interview_room.interview_chats
      byebug
      @interview_chat = InterviewChat.new(interview_room_id: @interview_room.id)
      #@post = Post.create(title: 'ビューティシャン申請', content: '面接予約', category_id: 1, price: 0, total_price: 0, service_fee: 0, trans_fee: 0, cancel_price: 0, business_user_id: @buser.id, business_user_name: @buser.name, time: Time.now, tax: 0)
      #@reserve = Reservation.new(user: @rei, post: @post, business_user_id: @buser.id)
      #@reserve = @rei.reservations.new(post: @post, business_user_id: @buser.id, start_time: Time.now).save(validate: false)
      flash[:notice] = "仮申請が申請されました。ご登録のメールアドレスの受信BOXをご確認ください。"
      UserMailer.with(business_user: @business_user).new_buser_mail.deliver_now
     end
  end

  # GET /resource/edit
  # def edit
  #   super

  # PUT /resource
  # def update
  #   super
  # end

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

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [:email, :tel, :postal_code, :prefecture_code, :city, :street, :other_address, :name, :category_id, :interval, :emergency_contact, :emergency_name ])
  end

  # If you have extra params to permit, append them to the sanitizer.
  def configure_account_update_params
    devise_parameter_sanitizer.permit(:account_update, keys: [:attribute, :tel, :email, :family_name_kana, :postal_code, :prefecture_code, :city, :street, :other_address, :name, :category_id, :interval, :emergency_contact, :emergency_name, ward_ids: []])
  end

  # ユーザー設定
  def update_resource(resource, params)
    resource.update_without_current_password(params)
  end

  # The path used after sign up.
  def after_sign_up_path_for(resource)
    #super(resource)
    mypage_path
  end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end

  def register_categories
    @business_user = resource
    business_user_params[:category_id].each do |category_id|
      @business_user.business_user_category_relations.create!(category_id: category_id, business_user_id: @business_user.id)
    end
  end


end
