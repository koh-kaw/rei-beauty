class UsersController < ApplicationController
  
  before_action :authenticate_user!, only: [:edit, :update]
  before_action :set_user, only: [:show, :edit, :update]
  
  def mypage
    redirect_to user_path(current_user)
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts
    
    if user_signed_in?
      #favorites = Favorite.where(user_id: current_user.id).pluck(:post_id)  # ログイン中のユーザーのお気に入りのpost_idカラムを取得
      favorites = Favorite.where(user_id: current_user.id).pluck(:business_user_id)  # ログイン中のユーザーのお気に入りのpost_idカラムを取得
      @favorite_list = BusinessUser.find(favorites)     # postsテーブルから、お気に入り登録済みのレコードを取得
    end

  end

  def personal
    
  end

  def image_destroy
    @user = User.find(params[:id])
    @user.remove_image!
    @user.save
    #@user.destroy
    respond_to do |format|
      format.html { redirect_to posts_url, notice: 'Post was successfully destroyed.' }
      format.json { head :no_content }
    end
  end


  def edit

    @user = User.find(params[:id])
    unless @user == current_user
      redirect_to user_path(@user)
    end

  end
  
  def update
    if current_user.update(user_params)
      redirect_to user_path(current_user)
    else
      redirect_to edit_user_path(current_user)
    end
  end


  # 住所自動入力-テスト
  def zipedit
    params.require(:user).permit(:postal_code, :prefecture_code, :city, :street)
  end


  private
    def set_user
      @user = User.find(params[:id])      
    end

    def user_params
      params.fetch(:user, {}).permit(:name, :image, :gender, :birth, :self_introduction, :station, :postal_code, :prefecture_code, :city, :street, :other_address, :tel, :family_name, :first_name, :family_name_kana, :first_name_kana, :station_id, :company_id, :line_id, :station, :ward_id, :agreement, :remove_image)
    end
end
