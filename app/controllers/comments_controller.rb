class CommentsController < ApplicationController
before_action :authenticate_user!

  def create
    @post = Post.find params[:post_id]
    @comment = @post.comments.build(comment_params)
    @comment.user = current_user

    if @comment.save
      redirect_to post_path(@post)
    else
      @comments = @post.comments.order(create_at: :desc)
      render 'posts/show'
    end
  end

  def destroy

    comment = Comment.find params[:id]
    if can?(:destroy, comment)
      comment.destroy
      redirect_to post_path(comment.post)
    else
      head :unauthorized
    end
  end

  private
  def comment_params
    params.require(:comment).permit(:body, :rating)
  end


end
