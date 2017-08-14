class TagsController < ApplicationController
  def index
    @tags = Tag.order(created_at: :desc)
  end

  def show
  @tag = Tag.find(params[:id])
  @posts = @tag.posts
  end


end
