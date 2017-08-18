class PostMapsController < ApplicationController
    def index
       posts = Post.where.not(longitude: nil, latitude: nil)
       @hash = Gmaps4rails.build_markers(posts) do |post, marker|
         marker.lat post.latitude
         marker.lng post.longitude
         marker.infowindow post.title

       end
     end
end
