class PostsController < ApplicationController
  before_action :find_post, only: [:edit, :destroy, :show, :update]
  before_action :authenticate_user!, except: [:index, :show]



  def index
    # visitor_lat = request.location.latitude
    # visitor_long = request.latitude.longitude
    visitor_lat = 49.2803221
    visitor_long = -123.112195

    @posts = Post.near([visitor_lat, visitor_long], 2)

    if params[:search].present?
    @posts = Post.near(params[:search])
  #   else
  #     location_info = request.location
  #     @posts = Post.near([location_info.latitude, location_info.longitude], 10)
    end

    respond_to do |format|
      format.html { render }
      format.json { render json: @posts }
      format.xml { render xml: @posts}
    end

  end


  def show
    @post = Post.find(params[:id])
    @comment = Comment.new
    @comments = @post.comments.order(created_at: :desc)
    @favourite = @post.favourites.find_by(user: current_user)
    @tags = @post.tags
    @user = @post.user
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
      marker.infowindow(post.title)
    end.to_json
  end
end
