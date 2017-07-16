class Admin::DashboardController < ApplicationController
  @stats = {
    post_count: Post.count,
    comment_count: Comment.count,
    user_cound: User.count
  }
end
