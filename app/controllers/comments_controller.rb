# frozen_string_literal: true

# Comment Controller
class CommentsController < ApplicationController
  # before_action :set_comment, only: [:show, :edit, :update, :destroy]
  before_action :set_product
  # GET /comments
  # GET /comments.json
  def index
    @comments = @product.comments
  end

  # GET /comments/1
  # GET /comments/1.json
  def show
    @comment = @product.comments.find(params[:id])
  end

  # GET /comments/new
  def new
    @comment = @product.comments.build(parent_id: params[:ancestry])
    respond_to do |format|
      format.js {}
    end
  end

  # GET /comments/1/edit
  def edit
    @comment = @product.comments.find(params[:id])
    respond_to do |format|
      format.js {}
    end
  end

  # POST /comments
  # POST /comments.json
  def create
    @comment = @product.comments.create(comment_params)
    respond_to do |format|
      if @comment.save
        format.html { redirect_to product_comment_path(@product, @comment), notice: 'Comment was successfully created.' }
        format.json { render :show, status: :created, location: @comment }
      else
        format.html { render :new }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
      format.js {}
    end
  end

  # PATCH/PUT /comments/1
  # PATCH/PUT /comments/1.json
  def update
    @comment = @product.comments.find(params[:id])
    respond_to do |format|
      if @comment.update(comment_params)
        format.html { redirect_to product_comment_path(@product, @comment), notice: 'Comment was successfully updated.' }
        format.json { render :show, status: :ok, location: @comment }
      else
        format.html { render :edit }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
      format.js {}
    end
  end

  # DELETE /comments/1
  # DELETE /comments/1.json
  def destroy
    @comment = @product.comments.find(params[:id])
    @comment.destroy
    respond_to do |format|
      format.html { redirect_to product_comments_path, notice: 'Comment was successfully destroyed.' }
      format.json { head :no_content }
      format.js {}
    end
  end

  def render_comment
    @comment = Comment.find(params[:comment_id])
    respond_to do |format|
      format.js
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  # def set_comment
  #   @comment = Comment.find(params[:id])
  # end

  # Never trust parameters from the scary internet, only allow the white list through.
  def comment_params
    user_id = current_user.id
    if params[:comment][:ancestry].empty?
      params.require(:comment).permit(:body, :rating).merge(user_id: user_id)
    else
      params.require(:comment).permit(:body, :rating, :ancestry).merge(user_id: user_id)
    end
  end

  def set_product
    @product = Product.find(params[:product_id])
  end
end