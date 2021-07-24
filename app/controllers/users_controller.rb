class UsersController < ApplicationController
  
  before_action :authenticate_user!, only: [:mypage, :show, :edit, :update]
  before_action :set_user, only: [:show, :edit, :update]
  
  def mypage
    redirect_to user_path(current_user)
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts
    
    favorites = Favorite.where(user_id: current_user.id).pluck(:post_id)  # ログイン中のユーザーのお気に入りのpost_idカラムを取得
    @favorite_list = Post.find(favorites)     # postsテーブルから、お気に入り登録済みのレコードを取得
  end

  def personal
    
  end

  def edit
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

  private
    def set_user
      @user = User.find(params[:id])      
    end

#    def user_params
#      params.fetch(:user, {}).permit(:username)
#    end
end
