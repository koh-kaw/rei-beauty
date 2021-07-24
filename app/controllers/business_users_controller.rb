class BusinessUsersController < ApplicationController
  before_action :authenticate_business_user!, only: [:buser_mypage, :show, :edit, :update]
  before_action :set_user, only: [:show, :edit, :update]
  
  def after_sign_in_path_for(resource)
    business_user_path(resource)
  end

  def buser_mypage
    redirect_to business_user_path(current_business_user)
  end

  def show
    @business_user = BusinessUser.find(params[:id])
  end

  def edit
  end
  
  def update
  end

  private
    def set_user
      @business_user = BusinessUser.find(params[:id])      
    end

end
