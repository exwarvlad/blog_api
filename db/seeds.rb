# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# set 100 different authors
authors = []
100.times { |index| authors << "blogger_#{index + 1}" }

# set 50 different ips
ips = []
50.times { |index| ips << "#{100 + index}.0.0.1" }

counter_authors = 0
counter_ips = 0
counter_likes = 1

200_000.times do |index|
  counter_authors = 1 if counter_authors == 100
  counter_ips = 0 if counter_ips == 50
  counter_likes = 1 if counter_likes == 8
  %x(curl -v -H "Accept: application/json" -H "Content-type: application/json" -X POST -d ' {"post": {"header":"x-fa-fafds","body":"yoyoy42", "ip":"#{ips[counter_ips]}", "user_login": "#{authors[counter_authors]}"}}'  http://localhost:3000/posts)
  if counter_likes == 7
    2.times do
      %x(curl -v -H "Accept: application/json" -H "Content-type: application/json" -X POST -d ' {"post": {"num": #{rand(1..5)}, "post_id": #{index + 1}}}'  http://localhost:3000/posts/create_mark)
    end
  end
  counter_authors += 1
  counter_ips += 1
  counter_likes += 1
end

# default curl query for actions
# %x(curl -v -H "Accept: application/json" -H "Content-type: application/json" -X POST -d ' {"post": {"header":"x-fa-fafds","body":"yoyoy42", "ip":"125.0.0.1", "user_login": "ttt538"}}'  http://localhost:3000/posts)
# %x(curl -v -H "Accept: application/json" -H "Content-type: application/json" -X POST -d ' {"post": {"num": 3, "post_id": 1055}}'  http://localhost:3000/posts/create_mark)
# %x(curl -v -H "Accept: application/json" -H "Content-type: application/json" -X GET -d ' {"post": {"n": 5}}'  http://localhost:3000/posts/give_top_posts)
# %x(curl -v -H "Accept: application/json" -H "Content-type: application/json" -X GET http://localhost:3000/posts/give_ip_list)