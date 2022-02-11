class RecruitsController < ApplicationController
  before_action :authenticate_user!, only: [:edit, :update, :new]

  def index
    @recruits = Recruit.all
  end

  def show
    @recruit = Recruit.find(params[:id])
    @user=User.find_by(id: @recruit.user_id)
  end

  def search
    @recruits = Recruit.search(params[:keyword])
    @keyword = params[:keyword]
    @category_id = params[:category_id]
    render recruits_index_path
  end

  def new
    byebug
    @recruit = Recruit.new
  end
  
  def create
    byebug
    @recruit = Recruit.new(recruit_params)
    byebug
    respond_to do |format|
      if @recruit.save
        format.html { redirect_to @recruit, notice: "登録に成功しました" }
        format.json { render :show, status: :created, location: @recruit }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @recruit.errors, status: :unprocessable_entity }
      end
    end
    #@recruit.save!
    #render recruits_index_path
  end

  def user_search
    @recruits = Recruit.search(params[:keyword])
    @keyword = params[:keyword]
    @category_id = params[:category_id]
    #render "index"
    render recruits_index_path
  end

private

def recruit_params
  params.require(:recruit).permit(:content, :category_id, :day, :from_day, :to_day, :start_time, :end_time, :from_price, :to_price, :area_id, :user_id, :user_name, :ward_id)
end

end
