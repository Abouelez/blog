class CommentsController < ApplicationController
  before_action :authenticate_user
  before_action :get_comment, only: [ :update, :destroy ]
  before_action :get_post, only: [ :create ]
  before_action :required_fields_on_create, only: [ :create ]



  def create
    comment_data = params.permit(:body)
    comment_data[:user_id] = @current_user.id

    comment = @post.comments.new(comment_data)
    if comment.save
      render json: { "message": "Comment published successfully" }, status: :created
    else
      render json: { "errors": comment.errors }, status: :unprocessable_entity
    end
  end

  def update
    authorize @comment
    if @comment.update(params.permit(:body))
      render json: { "message": "Comment updated successfully" }, status: :ok
    else
      render json: @comment.errors, status: :unprocessable_entity
    end
  end

  def destroy
    authorize @comment
    @comment.destroy
    head :no_content
  end


  private
  def get_post
    @post = Post.find(params[:post_id])
  rescue ActiveRecord::RecordNotFound
    render json: { error: "Post not found" }, status: :not_found
  end
  private
  def get_comment
    @comment = Comment.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: { error: "Post not found" }, status: :not_found
  end
  private
  def required_fields_on_create
    required([ "body" ])
  end
end
