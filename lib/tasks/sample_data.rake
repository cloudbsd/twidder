namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    Rake::Task['db:reset'].invoke
    make_users
  # make_user_relationships
  # make_microgroup
  # make_microposts
  # make_projects
  # make_tags
  # make_posts
  end
end


# ----------------------------------------------------------------------------
# User seed data
# ----------------------------------------------------------------------------

def make_users
  User.delete_all

  puts 'SETTING UP DEFAULT USER LOGIN'

  admin = User.create!(:name => 'admin',
                       :nickname => 'Administrator',
                       :email => 'admin@gmail.com',
                       :gravatar => 'user001.jpg',
                       :password => '888888',
                       :password_confirmation => '888888')
# admin.toggle!(:admin)
  puts 'New user created: ' << admin.nickname

  qi = User.create!(:name => 'qi',
                    :nickname => 'Qi Li',
                    :email => 'cloudbsd@gmail.com',
                    :gravatar => 'user_qi.jpg',
                    :password => '888888',
                    :password_confirmation => '888888')
# qi.toggle!(:admin)
  puts 'New user created: ' << qi.nickname

  ritchie = User.create!(:name => 'ritchie',
                         :nickname => 'Ritchie Li',
                         :email => 'ritchie.li@nebutown.com',
                         :gravatar => 'user002.jpg',
                         :password => '888888',
                         :password_confirmation => '888888')
# ritchie.toggle!(:admin)
  puts 'New user created: ' << ritchie.nickname

  danny = User.create!(:name => 'danny',
                       :nickname => 'Danny Ren',
                       :email => 'danny.ren@nebutown.com',
                       :gravatar => 'user003.jpg',
                       :password => '888888',
                       :password_confirmation => '888888')
  puts 'New user created: ' << danny.nickname

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
  puts '50 new users created'
end
