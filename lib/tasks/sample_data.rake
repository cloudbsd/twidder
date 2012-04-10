namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    Rake::Task['db:reset'].invoke
    make_users
    make_following_items
    make_group
    make_groups_users
    make_microposts
  # make_microgroup
  # make_projects
  # make_tags
    make_posts
  end
end


def print_title(title)
  puts "== #{title}"
end

def print_content(content)
  puts "   => #{content}"
end

# ----------------------------------------------------------------------------
# User seed data
# ----------------------------------------------------------------------------

def make_users
  User.delete_all

  print_title('setting up default user')

  admin = User.create!(:name => 'admin',
                       :nickname => 'Administrator',
                       :email => 'admin@gmail.com',
                       :gravatar => 'user001.jpg',
                       :password => '888888',
                       :password_confirmation => '888888')
# admin.toggle!(:admin)
  print_content 'add_user: ' << admin.nickname

  qi = User.create!(:name => 'qi',
                    :nickname => 'Qi Li',
                    :email => 'cloudbsd@gmail.com',
                    :gravatar => 'user_qi.png',
                    :password => '888888',
                    :password_confirmation => '888888')
# qi.toggle!(:admin)
  print_content 'add_user: ' << qi.nickname

  ritchie = User.create!(:name => 'ritchie',
                         :nickname => 'Ritchie Li',
                         :email => 'ritchie.li@nebutown.com',
                         :gravatar => 'user002.jpg',
                         :password => '888888',
                         :password_confirmation => '888888')
# ritchie.toggle!(:admin)
  print_content 'add_user: ' << ritchie.nickname

  danny = User.create!(:name => 'danny',
                       :nickname => 'Danny Ren',
                       :email => 'danny.ren@nebutown.com',
                       :gravatar => 'user003.jpg',
                       :password => '888888',
                       :password_confirmation => '888888')
  print_content 'add_user: ' << danny.nickname

  50.times do |n|
    name = format "user%03d", n+1
    nickname = Faker::Name.name
    email = name + "@gmail.org"
    gravatar = format "user%03d.jpg", n%29+1
    password = "888888"
    User.create!(name: name,
                 nickname: nickname,
                 email: email,
                 gravatar: gravatar,
                 password: password,
                 password_confirmation: password)
  end
  print_content "add_user: 50 users created"
end


# ----------------------------------------------------------------------------
# FollowingItem seed data
# ----------------------------------------------------------------------------

def make_following_items
  FollowingItem.delete_all

  print_title('setting up default following items')

  users = User.all
  qi = User.find_by_email('cloudbsd@gmail.com')
  followees = users[3..50]
  followers = users[3..40]
  followees.each { |followee| qi.follow!(followee) }
  followers.each { |follower| follower.follow!(qi) }
end


# ----------------------------------------------------------------------------
# Group seed data
# ----------------------------------------------------------------------------

def make_group
  Group.delete_all

  print_title('setting up default groups')

  # microgroups belong to Qi Li
  strdesc = %{Microgroup is a continuous integration server. It keeps everyone in your team informed about the health and progress of your project. CC.rb is easy to install, pleasant to use and simple to hack. It's written in Ruby and maintained in their spare time by developers at ThoughtWorks, a software development consultancy.}

  10.times do |n|
    name = format "user%03d", n+1
    Group.create!(name: name,
                  description: strdesc)
  end
  print_content "add_group: 10 groups created"
end


# ----------------------------------------------------------------------------
# GroupsUsers seed data
# ----------------------------------------------------------------------------

def make_groups_users
  GroupsUsers.delete_all

  print_title('setting up default group-user items')

  users = User.all
  followers = users[1..3]

  groups = Group.all

  groups.each do |group|
    followers.each do |follower|
      follower.join!(group)
    # follower.groups << group
    end
  end
end


# ----------------------------------------------------------------------------
# Micropost seed data
# ----------------------------------------------------------------------------

def make_microposts
  print_title('setting up default microposts')

  Micropost.delete_all

  qi = User.find_by_email('cloudbsd@gmail.com')
  99.times do |n|
    content = Faker::Lorem.sentence(5)
    micropost = qi.microposts.build(content: content)
    micropost.group_id = 0
    micropost.save
  # qi.microposts.create(content: content, group_id: 0)
  end
  print_content "add_micropost: created by #{qi.nickname}"

  ritchie = User.find_by_email('ritchie.li@nebutown.com')
  99.times do |n|
    content = Faker::Lorem.sentence(5)
    micropost = ritchie.microposts.build(content: content)
    micropost.group_id = 0
    micropost.save
  # ritchie.microposts.create(content: content, group_id: 0)
  end
  print_content "add_micropost: created by #{ritchie.nickname}"

# users = User.all(limit: 6)
  users = User.all
  20.times do
    content = Faker::Lorem.sentence(5)
    users.each do |user|
      micropost = user.microposts.build(content: content)
      micropost.group_id = 0
      micropost.save
    # user.microposts.create!(content: content, group_id: 0)
    end
  end
  print_content "add_micropost: created by other users"
end


# ----------------------------------------------------------------------------
# Post seed data
# ----------------------------------------------------------------------------

def make_posts
  print_title('setting up default microposts')

  Post.delete_all

  qi = User.find_by_email('cloudbsd@gmail.com')
  for i in 1..10 do
    str_title = "Github Post #{i}"
    str_content = %{At GitHub, we're constantly creating and using Pull Requests. They're an indispensable tool in our internal workflow, and a key part of making open source project management with GitHub so great. We're excited to make using them easier!}
    qi.posts.create(title: str_title, content: str_content)
  end
  print_content "add_post: 10 posts created by #{qi.nickname}"

  ritchie = User.find_by_email('ritchie.li@nebutown.com')
  for i in 1..10 do
    str_title = "Jake Douglas is a GitHubber Title #{i}"
    str_content = %{Today Jake Douglas joins us as a GitHubber. Jake is going to be helping us squeeze as much performance as we can out of our backend systems. We're really excited to have him and we can't wait to see what he comes up with.}
    ritchie.posts.create(title: str_title, content: str_content)
  end
  print_content "add_post: 10 posts created by #{ritchie.nickname}"
end

