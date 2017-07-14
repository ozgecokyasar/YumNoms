# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Post.destroy_all
Comment.destroy_all

30.times do
  Post.create title: Faker::ChuckNorris.fact,
              body: Faker::Hacker.say_something_smart
end

posts = Post.all

posts.each do |po|
  rand(1..5).times do
    Comment.create(body: Faker::RickAndMorty.quote, post: po)
  end
end

comments = Comment.all
