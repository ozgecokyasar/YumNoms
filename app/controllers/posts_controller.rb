class PostsController < ApplicationController
  before_action :find_post, only: [:edit, :destroy, :show, :update]
  before_action :authenticate_user!, except: [:index, :show]
  before_action :authorize_user!, only: [:edit, :destroy, :update]

  def index
    @posts = Post.order(created_at: :desc)
  end

  def show
    # @post = Post.find params[:id]
    @comments = Comment.new
    @comments = @post.comments.order(created_at: :desc)
  end

  def new
    @post = Post.new
  end

  def create
    # post_params = params.require(:post).permit(:title, :body)
    @post = Post.new post_params
    @post.user = current_user

    if @post.save
      redirect_to posts_path(@post)
    else
      render :new
    end
  end

  def edit
    # @post = Post.find params[:id]
    # if @post.user != current_user
    #   redirect_to root_path, alert: 'access denied'
    # end
  end

  def update
    # @post = Post.find params[:id]
    # post_params = params.require(:post).permit(:title, :body)

    if @post.update post_params
      redirect_to post_path(@post)
    else
      render :edit
    end
  end

  def destroy
    # @post = Post.find params[:id]
    @post.destroy
    redirect_to posts_path
  end

private

  def post_params
    params.require(:post).permit(:title, :body)
  end

  def authorize_user!
    unless can?(:manage, @post)
      head :unauthorized
    end
  end

  def find_post
    @post = Post.find params[:id]
  end

end
