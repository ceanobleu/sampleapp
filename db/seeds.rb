# Create a main sample user.
User.create!(name: "Example User",
             email: "example@railstutorial.org",
             password: "foobar",
             password_confirmation: "foobar",
             admin: true,
             activated: true,
             activated_at: Time.zone.now)
             
User.create!(name: "Admin User",
             email: "admin@admin.com",
             password: "123123",
             password_confirmation: "123123",
             admin: true,
             activated: true,
             activated_at: Time.zone.now)

User.create!(name: "Test User",
             email: "test@test.com",
             password: "123123",
             password_confirmation: "123123",
             activated: true,
             activated_at: Time.zone.now)

             
# Generate a bunch of additional users.
99.times do |n|
  name = Faker::Name.name
  email = "example-#{n+1}@railstutorial.org"
  password = "password"
  User.create!(name: name,
               email: email,
               password: password,
               password_confirmation: password,
               activated: true,
               activated_at: Time.zone.now)
end
               
#Generate microposts for a subset of users.
users = User.order(:created_at).take(6)
50.times do
  content = Faker::Lorem.sentence(word_count: 5)
  users.each { |user| user.microposts.create!(content: content) }
end

# Create following relationships.
users = User.all
user = users.first
following = users[2..50]
followers = users[3..40]
following.each { |followed| user.follow(followed) }
followers.each { |follower| follower.follow(user) }

user2 = users.second
following2 = users[5..50]
followers2 = users[8..40]
following2.each { |followed| user2.follow(followed) }
followers2.each { |follower| follower.follow(user2) }

user3 = users.third
following3 = users[6..47]
followers3 = users[7..22]
following3.each { |followed| user3.follow(followed) }
followers3.each { |follower| follower.follow(user3) }