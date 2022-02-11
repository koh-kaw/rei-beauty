class Accounts::AvatarsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_profile

  def show
  end

  def update
      respond_to do |format|
          if @profile.update(profile_params)
              format.html { 
                  redirect_to account_path, 
                  notice: "Profile was successfully updated."
              }
          else
              format.html {
                  render :edit
              }
          end
      end
  end

  private
  def set_profile
      @profile = current_user.profile
  end

  def profile_params
      params.require(:profile).permit(:avatar, :avatar_cache, :remove_avatar)
  end
end