json.array! @posts do |post|
  # Inside of this block, the method used with json will determine
  # the name of the key in the json response.
  json.id post.id
  json.title post.title
  json.created_at post.created_at.to_formatted_s(:long)
  json.updated_at post.updated_at.to_formatted_s(:long)
end
