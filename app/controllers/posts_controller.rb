class PostsController < ApplicationController
  before_action :authenticate_user
  before_action :get_post, only: [ :update, :show, :destroy ]
  before_action :required_fields_on_create, only: [ :create ]

  def index
  posts = Post.includes(:user, :comments)
  render json: posts, include: [ "user", "comments.user" ], status: :ok
  end
  def create
    post_data = params.permit(:title, :body, tags: [])
    Rails.logger.debug(post_data)
    post_data[:tags] = post_data[:tags].join(",")
    post_data[:user_id] = @current_user.id

    post = Post.new(post_data)

    if post.save
      render json: { message: "Post Created Successfully.", post: PostSerializer.new(post) }, status: :created
    else
      render json: { errors: post.errors }, status: :unprocessable_entity
    end
  end

  def show
    render json: @post, include: [ "user", "comments.user" ],  status: :ok
  end

  def update
    authorize @post
    if @post.update(params.permit(:title, :body, :tags))
      render json: { message: "Post updated successfully", post: PostSerializer.new(@post) }, status: :ok
    else
      render json: @post.errors, status: :unprocessable_entity
    end
  end

  def destroy
    authorize @post
    @post.destroy
    head :no_content
  end


  private
  def required_fields_on_create
    self.required([ "title", "body", "tags" ])
  end

  private
  def get_post
    @post = Post.includes(:user, :comments).find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: { error: "Post not found" }, status: :not_found
  end
end
