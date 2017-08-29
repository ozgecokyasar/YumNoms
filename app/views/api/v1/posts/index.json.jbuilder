json.array! @posts do |post|
  json.id post.id
  json.title post.title
  json.body post.body
  json.full_address post.full_address
  json.start_time post.start_time
  json.end_time post.end_time
  json.price post.price
  json.author_name post.user.full_name
  json.created_at post.created_at.to_formatted_s(:long)
  json.updated_at post.updated_at.to_formatted_s(:long)
end
