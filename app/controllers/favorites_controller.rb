class FavoritesController < ApplicationController
#before_action :set_post
#before_action :authenticate_user!
# ログイン中のユーザーのみに許可（未ログインなら、ログイン画面へ移動）

#  def create
#    @favorite = current_user.favorites.create(post_id: params[:post_id])
#    redirect_back(fallback_location: root_path)
#  end

  def create
    byebug
    @favorite = current_user.favorites.create(business_user_id: params[:business_user_id])
    @favorite.save
    byebug
    redirect_back(fallback_location: root_path)
  end

  def destroy
    @favorite = Favorite.find_by(business_user_id: params[:business_user_id], user_id: current_user.id)
    @favorite.destroy
    redirect_back(fallback_location: root_path)
  end
end