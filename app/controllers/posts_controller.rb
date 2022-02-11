class PostsController < ApplicationController
  #before_action :authenticate_user!, only: [:show, :edit, :update, :new]
  #before_action :authenticate_business_user!, only: [:show, :edit, :update, :new]
  
  #before_action :set_post, only: %i[show edit update destroy ]

  # GET /posts or /posts.json
  def index
    @posts = Post.all
    @business_user = BusinessUser
  end

  # GET /posts/1 or /posts/1.json
  def show
    @post = Post.find(params[:id])
    @favorite = Favorite.new
    @category = Category.find(@post.category_id)
    #@business_user = BusinessUser.find(params[:business_user_id])
    @business_user = BusinessUser.find(@post.business_user_id)
  end




  # GET /posts/new
  def new
    @post = Post.new
    @business_user = current_business_user
    @delivery_categories = @business_user.business_user_category_relations
  end

  # GET /posts/1/edit
  def edit
    @post = Post.find(params[:id])
    @business_user = current_business_user
  end

  # POST /posts or /posts.json
  def create
    @post = Post.new(post_params)
    respond_to do |format|
      if @post.save
        format.html { redirect_to @post, notice: "登録に成功しました" }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1 or /posts/1.json
  def update
    @post = Post.find(params[:id])
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to @post, notice: "Post was successfully updated." }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1 or /posts/1.json
  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    respond_to do |format|
      format.html { redirect_to posts_url, notice: "Post was successfully destroyed." }
      format.json { head :no_content }
    end
    redirect_to("/")
  end


  # 予約 開始日のAJAX
  def preload
    today = Date.today
    reservations = @post.reservations.where("start_date >= ? OR end_date >= ?", today, today)
    render json: reservations
  end

  #　予約 終了日のAJAX
  def preview
    start_date = Date.parse(params[:start_date])
    end_date = Date.parse(params[:end_date])
    output = {
      conflict: is_conflict(start_date, end_date, @post)
    }
    render json: output
  end


  #def search
  #  @posts = Post.search(params[:keyword])
  #  @keyword = params[:keyword]
  #  @category_id = params[:category_id]
  #  render "index"
  #end

  def search
    # viewのform_tagにて
    # 選択したmodelの値を@modelに代入。
    @keyword = params["keyword"]
    # 選択した検索方法の値を@methodに代入。
    @category = params["category_id"]
    # 検索ワードを@contentに代入。
    @ward = params["ward_id"]
    # @model, @content, @methodを代入した、
    # search_forを@recordsに代入。
    @posts = Post.search(@keyword, @ward, @category)
    render "index"
  end

  def pickup
    @category = params["category_id"]
    
    @posts = Post.pickup(@category)
    render "index"
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def post_params
      params.require(:post).permit(:title, :content, :category_id, :price, :image, :time, :start_time, :end_time, :weekday, :business_user_id, :business_user_name, :cancel_price, :total_price, :service_fee, :trans_fee, :tax)
    end


    # 予約　プライベートメソッド
    def is_conflict(start_date, end_date, post)
      check = post.reservations.where("? < start_date AND end_date < ?", start_date, end_date)
      check.size > 0? true : false
    end

    def reservation_params
      params.require(:reservation).permit(:start_date, :end_date, :post_id, :day, :time, :user_id, :start_time, :business_user_id, :price, :cancel_price, :tax)
   end 


end
