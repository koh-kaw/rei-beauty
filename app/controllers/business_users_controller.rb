class BusinessUsersController < ApplicationController
  before_action :authenticate_business_user!, only: [ :edit, :update]
  before_action :set_user, only: [:edit, :update]
  
  def after_sign_in_path_for(resource)
    business_user_path(resource)
  end

  def buser_mypage
    redirect_to business_user_path(current_business_user)
  end

  def index
    @posts = Post.all
    @business_users = BusinessUser.all
  end

  # 収益
  def revenue
    @buser = current_business_user
    @reservations = Reservation.where(business_user_id: current_business_user.id)
    #@reserves = current_business_user.reservations.where(done: :true)
    @reserves = current_business_user.reservations
    @this_month = Date.today.all_month

    @first_half = Time.current.all_month
    @latter_half = Time.current.all_month

  end

  def show
    @business_user = BusinessUser.find(params[:id])
    @areas = BusinessUserTreatmentArea.where(business_user_id: @business_user.id)
    @delivery_categories = BusinessUserCategoryRelation.where(business_user_id: @business_user.id)
    @post = Post.where(business_user_id: @business_user.id)
    @review = Review.new
    @reviews = @business_user.reviews
    @favorite = Favorite.new
    #@reviews = Review.where(business_user_id: @business_user.id)
  end
    

  def setting
    @business_user = BusinessUser.find(params[:id])
    @off_business = OffBusiness.where(business_user_id: params[:id])
    @post = Post.where(business_user_id: @business_user.id)
  end

  def edit
    @business_user = BusinessUser.find(params[:id])
    byebug
    now_wards = @business_user.business_user_treatment_areas
    Rails.logger.debug now_wards
    @current_wards = []
    byebug
    now_wards.each do |n|
      byebug
      @current_wards.push(n.ward_id)
    end
    byebug
    binging.pry
    p @current_wards
    Rails.logger.debug @current_wards
    
    #@wards = Ward.where(id: @buser.ward_id.split(','))
    @wards = Ward.where(id: @business_user.ward_id.split(','))
    #@business_user_treatment_areas = @buser.business_user_treatment_areas.build(ward_id: business_user_params[:ward_id]) 
    @business_user.business_user_treatment_areas.build(ward_id: business_user_params[:ward_id], business_user_id: params[:id]) 

    # カテゴリ
    byebug
    check_categories = @business_user.business_user_category_relations
    @current_categories = []
    check_categories.each do |c|
      @current_categories.push(c.category_id)
    end
    @business_user.business_user_category_relations.build(category_id: business_user_params[:category_ids], business_user_id: @business_user.id) 

  end

  def update
    @business_user = BusinessUser.find(params[:id])
    byebug
    #if @business_user.business_user_treatment_areas.will_save_change_to_ward_id?

    if business_user_params[:ward_id]
      register_wards
    elsif business_user_params[:category_ids]
      register_categories
    end

    #if @business_user.business_user_category_relations.will_save_change_to_category_ids?  
    
      #@business_user.update(business_user_params)
    #end
    byebug
    @business_user.update(business_user_params)
    #@business_user.business_user_treatment_areas.create!(ward_id: business_user_params[:ward_id], business_user_id: params[:id]) 

    redirect_to business_user_path
  end

  def search
    if params[:search_keyword].present?
      @business_users = BusinessUser.where('name LIKE ?', "%#{params[:search_keyword]}%")
    else
      @business_users = BusinessUser.none
    end
  end

  #ランキング

  private
    def set_user
      @business_user = BusinessUser.find(params[:id])      
    end

    def business_user_params
      params.fetch(:business_user, {}).permit(:interval, :tel, :email, :family_name_kana, :remove_image, category_ids: [], ward_id: [])
    end
    
    def register_wards
      @business_user = BusinessUser.find(params[:id])
      if @now_ward = @business_user.business_user_treatment_areas
        @now_ward.each do |now|
          now.destroy
        end
      end
      business_user_params[:ward_id].each do |ward_id|
        @business_user.business_user_treatment_areas.create!(ward_id: ward_id)
      end
    end

    def register_categories
      @business_user = BusinessUser.find(params[:id])
      if check_categories = @business_user.business_user_category_relations
        check_categories .each do |check|
          check.destroy
        end
      end
      business_user_params[:category_ids].each do |category_id|
        @business_user.business_user_category_relations.create!(category_id: category_id, business_user_id: @business_user.id)
      end
    end

end
