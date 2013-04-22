namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    Rake::Task['db:reset'].invoke
    make_users
    make_following_items
    make_group
    make_groups_users
    make_microposts
    make_microgroups
    make_projects
  # make_tags
    make_posts
  end
end


def print_title(title)
  puts "== #{title}"
end

def print_content(content, level = 1)
  indent = '   ' * level
  puts "#{indent}=> #{content}"
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
                       :password => 'password',
                       :password_confirmation => 'password')
# admin.toggle!(:admin)
  print_content 'add_user: ' << admin.nickname

  qi = User.create!(:name => 'qi',
                    :nickname => 'Qi Li',
                    :email => 'cloudbsd@gmail.com',
                    :gravatar => 'user_qi.png',
                    :password => 'password',
                    :password_confirmation => 'password')
# qi.toggle!(:admin)
  print_content 'add_user: ' << qi.nickname

  ritchie = User.create!(:name => 'ritchie',
                         :nickname => 'Ritchie Li',
                         :email => 'ritchie.li@nebutown.com',
                         :gravatar => 'user002.jpg',
                         :password => 'password',
                         :password_confirmation => 'password')
# ritchie.toggle!(:admin)
  print_content 'add_user: ' << ritchie.nickname

  danny = User.create!(:name => 'danny',
                       :nickname => 'Danny Ren',
                       :email => 'danny.ren@nebutown.com',
                       :gravatar => 'user003.jpg',
                       :password => 'password',
                       :password_confirmation => 'password')
  print_content 'add_user: ' << danny.nickname

  50.times do |n|
    name = format "user%03d", n+1
    nickname = Faker::Name.name
    email = name + "@gmail.org"
    gravatar = format "user%03d.jpg", n%29+1
    password = "password"
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

  20.times do |n|
    name = format "user%03d", n+1
    Group.create!(name: name, description: strdesc)
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
  followers = users[5..20]

  groups = Group.all

  groups.each do |group|
    followers.each do |follower|
      follower.join!(group)
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
# Microgroup seed data
# ----------------------------------------------------------------------------

def make_microgroups
  print_title('setting up default microgroups')

  Microgroup.delete_all

# users = User.all
# grp_users = users[3..40]

  # microgroups belong to Qi Li
  strdesc = %{Microgroup is a continuous integration server. It keeps everyone in your team informed about the health and progress of your project. CC.rb is easy to install, pleasant to use and simple to hack. It's written in Ruby and maintained in their spare time by developers at ThoughtWorks, a software development consultancy.}

  qi = User.find_by_email('cloudbsd@gmail.com')
  for i in 1..10 do
    name = "Qi Microgroup #{i}";
    grp = Group.find(i)
    mgrp = qi.microgroups.create(name: name, description: strdesc, group_id: grp.id)
    print_content "add_microgroup: created by #{qi.nickname}"
    grp.users.each do |user|
      # user create micropost belonging to the microgroup
      content = Faker::Lorem.sentence(5)
      micropost = user.microposts.build(content: content)
      micropost.group_id = i
      micropost.save
    # user.microposts.create(content: content, microgroup_id: grp.id)
    end
    print_content "add_micropost: #{grp.users.count} microposts are created by \"#{qi.nickname}\" and Group \"#{grp.name}\"", 2
  end

  # microgroups belong to Ritchie Li
  strdesc = %{At Microgroup, we're constantly creating and using Pull Requests. They're an indispensable tool in our internal workflow, and a key part of making open source project management with GitHub so great. We're excited to make using them easier!}

  ritchie = User.find_by_email('ritchie.li@nebutown.com')
  for i in 11..20 do
    name = "Ritchie Microgroup #{i}";
    grp = Group.find(i)
    mgrp = ritchie.microgroups.create(name: name, description: strdesc, group_id: grp.id)
    print_content "add_microgroup: created by #{ritchie.nickname}"
    grp.users.each do |user|
      # user create micropost belonging to the microgroup
      content = Faker::Lorem.sentence(5)
      micropost = user.microposts.build(content: content)
      micropost.group_id = i
      micropost.save
    # user.microposts.create(content: content, microgroup_id: grp.id)
    end
    print_content "add_micropost: #{grp.users.count} microposts are created by \"#{ritchie.nickname}\" and Group \"#{grp.name}\"", 2
  end
end


# ----------------------------------------------------------------------------
# Project seed data
# ----------------------------------------------------------------------------

def do_make_project(user, name, strdesc, strpath, strgravatar)
  grp = Group.create!(name: name, description: strdesc)
  prj = user.projects.create(name: name, description: strdesc, path: strpath, group: grp, gravatar: strgravatar)
  print_content "add_project: #{prj.name} created by #{user.nickname}"
  return prj
end

def do_make_review(user, project, file, line)
  content = "review created by #{user.nickname} on #{line} of #{file}"
  review = user.reviews.build(content: content, file: file, line: line)
  review.project = project
  review.save
  print_content "add_review: #{content}", 2
  return review
end

def make_projects
  print_title('setting up default projects')

  Project.delete_all

  # Clang
  cc_name = 'Clang'
  cc_desc = %{Clang is an "LLVM native" C/C++/Objective-C compiler, which aims to deliver amazingly fast compiles (e.g. about 3x faster than GCC when compiling Objective-C code in a debug configuration), extremely useful error and warning messages and to provide a platform for building great source level tools. The Clang Static Analyzer is a tool that automatically finds bugs in your code, and is a great example of the sort of tool that can be built using the Clang frontend as a library to parse C/C++ code.}
  cc_path = '/Users/liqi/github/clang3.0'
  qi = User.find_by_email('cloudbsd@gmail.com')
  prj = do_make_project(qi, cc_name, cc_desc, cc_path, 'project001.jpg')

  # Redis
  cc_name = 'Redis'
  cc_desc = %{The script will ask you a few questions and will setup everything you need to run Redis properly as a background daemon that will start again on system reboots.}
  cc_path = '/Users/liqi/github/redis-2.4.13'
  qi = User.find_by_email('cloudbsd@gmail.com')
  prj = do_make_project(qi, cc_name, cc_desc, cc_path, 'project001.jpg')

  # CruiseControl.rb Project
  cc_name = 'CruiseControl.rb';
  cc_desc = %{CruiseControl.rb is a continuous integration server. It keeps everyone in your team informed about the health and progress of your project. CC.rb is easy to install, pleasant to use and simple to hack. It's written in Ruby and maintained in their spare time by developers at ThoughtWorks, a software development consultancy.}
  cc_path = '/Users/liqi/github/cruisecontrol.rb'
  qi = User.find_by_email('cloudbsd@gmail.com')
  prj = do_make_project(qi, cc_name, cc_desc, cc_path, 'project001.jpg')

  # Msgpack Project
  msg_name = 'Msgpack';
  msg_desc = %{MessagePack is a binary-based efficient object serialization library. It enables to exchange structured objects between many languages like JSON. But unlike JSON, it is very fast and small.}
  msg_path = '/Users/liqi/github/msgpack'

  prj = do_make_project(qi, msg_name, msg_desc, msg_path, 'project002.jpg')
  file = 'cpp/src/objectc.c'
  for line in 30..50 do
    review = do_make_review(qi, prj, file, line)
  end

  for i in 1..7 do
    strname = msg_name + i.to_s
    strdesc = msg_desc
    strpath = msg_path + i.to_s
    gravatar = format "project%03d.jpg", i
    prj = do_make_project(qi, strname, strdesc, strpath, gravatar)
  end
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

