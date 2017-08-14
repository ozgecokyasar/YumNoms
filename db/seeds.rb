# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Post.destroy_all
Comment.destroy_all
Category.destroy_all

categories = ['Lunchtime', 'Happy Hour', 'Late Night'];

categories.each do |category|
  Category.create(name: category)
end

30.times do
  category = Category.all.sample
  user = User.all.sample

end
