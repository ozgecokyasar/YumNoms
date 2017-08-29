class PostSerializer < ActiveModel::Serializer
  attributes :id, :title, :body, :address, :city, :postcode, :category_id, :tag_list, :start_time, :end_time, :price, :image
  belongs_to :user, key: :author
  has_many :comments

   class UserSerializer < ActiveModel::Serializer
     attributes :id, :first_name, :last_name
   end

   class CommentSerializer < ActiveModel::Serializer
     attributes :id, :body, :rating, :author_full_name, :created_at, :updated_at

     def author_full_name
       object.user&.full_name
     end
   end


end
