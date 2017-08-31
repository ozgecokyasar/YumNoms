class Api::V1::PostsController < Api::ApplicationController
  before_action :authenticate_user!
  before_action :find_post, only: [:show]

  def show
    render json: @post
  end

  def index
    @posts = Post.order(created_at: :desc).includes(:user)
    render json: @posts
  end

  def create
    post = Post.new(post_params)
    post.user = current_user

    if post.save
      render json: { id: post.id }
    else
      render json: { error: post.errors.full_messages }
    end
  end

  def destroy
    if @post.destroy
      head :ok
    else
      head :bad_request
    end
  end

  private
  def post_params
    params.require(:post).permit(:title, :body, :address, :city, :postcode, :country, :category_id, :tag_list, :start_time, :end_time, :price, :image)
  end

  def find_post
    @post = Post.find(params[:id])
  end
end
