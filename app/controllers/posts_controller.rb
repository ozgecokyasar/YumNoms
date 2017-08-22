class PostsController < ApplicationController
  before_action :find_post, only: [:edit, :destroy, :show, :update]
  before_action :authenticate_user!, except: [:index, :show]

  def index
    @posts = Post.all
    if params[:search].nil?
      @posts = Post.where.not(latitude: nil, longitude: nil)
    else
      @search = params[:search].split(',').first
      @posts = Post.search(@search).where.not(latitude: nil, longitude: nil).order("created_at DESC")
    end

    @locations = locations_json(@posts)
  end

  def show
    @post = Post.find(params[:id])
    @comment = Comment.new
    @comments = @post.comments.order(created_at: :desc)
    @favourite = @post.favourites.find_by(user: current_user)
    @tags = @post.tags
  end

  def new
    @post = Post.new
  end

  def create
    # post_params = params.require(:post).permit(:title, :body)
    @post = Post.new post_params
    @post.user = current_user

    if @post.save
      redirect_to current_user
    else
      render :new
    end
  end

  def edit
    @post = Post.find params[:id]
    redirect_to root_path, alert: "access denied" unless can? :edit, @post
  end

  def update
    @post = Post.find params[:id]
    # post_params = params.require(:post).permit(:title, :body)
    redirect_to root_path, alert: "access denied" unless can? :update, @post
    if @post.update post_params
      redirect_to @post, notice: "post updated"
    else
      render :edit
    end
  end

  def destroy
    redirect_to root_path, alert: "access denied" unless can? :destroy, @post || current_user.is_admin?
    @post.destroy
    redirect_to posts_path, :notice => "your post has been deleted"
  end

private

  def post_params
    params.require(:post).permit(:title, :body, :address, :city, :postcode, :country, :category_id, :tag_list, :start_time, :end_time, :price, :image)
  end

  def authorize_user!
    unless can?(:manage, @post)
      head :unauthorized
    end
  end

  def find_post
    @post = Post.find params[:id]
  end

  def locations_json(posts)
    Gmaps4rails.build_markers(posts) do |post, marker|
      marker.lat post.latitude
      marker.lng post.longitude
      marker.infowindow post.title
    end.to_json
  end
end
