class PostCategoryRelationsController < ApplicationController
  before_action :set_post_category_relation, only: %i[ show edit update destroy ]

  # GET /post_category_relations or /post_category_relations.json
  def index
    @post_category_relations = PostCategoryRelation.all
  end

  # GET /post_category_relations/1 or /post_category_relations/1.json
  def show
  end

  # GET /post_category_relations/new
  def new
    @post_category_relation = PostCategoryRelation.new
  end

  # GET /post_category_relations/1/edit
  def edit
  end

  # POST /post_category_relations or /post_category_relations.json
  def create
    @post_category_relation = PostCategoryRelation.new(post_category_relation_params)

    respond_to do |format|
      if @post_category_relation.save
        format.html { redirect_to @post_category_relation, notice: "Post category relation was successfully created." }
        format.json { render :show, status: :created, location: @post_category_relation }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @post_category_relation.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /post_category_relations/1 or /post_category_relations/1.json
  def update
    respond_to do |format|
      if @post_category_relation.update(post_category_relation_params)
        format.html { redirect_to @post_category_relation, notice: "Post category relation was successfully updated." }
        format.json { render :show, status: :ok, location: @post_category_relation }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @post_category_relation.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /post_category_relations/1 or /post_category_relations/1.json
  def destroy
    @post_category_relation.destroy
    respond_to do |format|
      format.html { redirect_to post_category_relations_url, notice: "Post category relation was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post_category_relation
      @post_category_relation = PostCategoryRelation.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def post_category_relation_params
      params.require(:post_category_relation).permit(:post_id, :category_id)
    end
end
