# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


%x(curl -v -H "Accept: application/json" -H "Content-type: application/json" -X POST -d ' {"post": {"header":"x-fa-fafds","body":"yoyoy4242", "ip":"127.0.0.1", "user_login": "ttt424242"}}'  http://localhost:3000/posts)
%x(curl -v -H "Accept: application/json" -H "Content-type: application/json" -X POST -d ' {"post": {"num": 5, "post_id": 1055}}'  http://localhost:3000/posts/create_mark)
%x(curl -v -H "Accept: application/json" -H "Content-type: application/json" -X POST -d ' {"post": {"n": 5}}'  http://localhost:3000/posts/give_top_posts)