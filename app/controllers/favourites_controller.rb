class FavouritesController < ApplicationController
    before_action :find_post, only: [:create]
  before_action :find_favourite, only: [:destroy]



  def create
    favourite = Favourite.new user: current_user, post: @post

    if favourite.save
      redirect_to @post, notice: "thanks for favouriting"
    else
      redirect_to @post, alert: favourite.errors.full_messages.join(', ')
    end
  end

  def destroy
    if @favourite.destroy
      redirect_to @favourite.post, notice: ":("
    else
      redirect_to @favourite.post, alert: @favourite.errors.full_messages.join(', ')
    end
  end

  private
  def find_favourite
    @favourite = Favourite.find(params[:id])
  end

  def find_post
    @post = Post.find(params[:post_id])
  end
end
