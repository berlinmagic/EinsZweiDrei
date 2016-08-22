# encoding: utf-8
#
#   App - DataBase - Seeds
#

## Savely reset Database
puts 'Drop all tables in #{ActiveRecord::Base.connection.adapter_name} DB'
if Rails.env.production?
  ActiveRecord::Base.connection.tables.each { |t| ActiveRecord::Base.connection.execute("DROP TABLE IF EXISTS #{t} CASCADE") }
else
  ActiveRecord::Base.connection.tables.each { |t| ActiveRecord::Base.connection.drop_table t }
end
Rake::Task["db:migrate"].invoke

puts "."
puts ".."
puts "..."
puts "Build Users"
puts "..."

SEED_USERS = [
  { # 1
    :last_name   => "Strange",
    :first_name  => "Austin",
    :sex         => "male",
    :pic         => "austin",
    :email       => "admin@berlinmagic.com",
    :password    => "sX8Pk2FUvMT8qeS"
  },
  { # 2
    :last_name   => "Wetzel",
    :first_name  => "Torsten",
    :sex         => "male",
    :pic         => "torsten",
    :email       => "torsten@berlinmagic.com",
    :password    => "rZcDz6Y7ExE6s5w"
  },
  { # 3
    :last_name   => "Sebald",
    :first_name  => "Marco",
    :sex         => "male",
    :pic         => "marco",
    :email       => "marco@berlinmagic.com",
    :password    => "TqvYwCcCmtkKSaG"
  },
  { # 4
    :last_name   => "Kahler",
    :first_name  => "Dennis",
    :sex         => "male",
    # :pic         => "polka",
    :email       => "kahler.dennis@googlmail.com",
    :password    => "hochzeit2"
  }
]


uploader = Dragonfly.app(:images)

SEED_USERS.each do |usr|
  that = User.new(
                            :email                  => usr[:email],
                            :password               => usr[:password],
                            :password_confirmation  => usr[:password],
                            :gender                 => usr[:sex],
                            :last_name              => usr[:last_name],
                            :first_name             => usr[:first_name] && !usr[:first_name].blank? ? usr[:first_name] : nil,
                            :signup_via             => "seed"
                  )
  that.skip_confirmation!
  if that.email == 'admin@berlinmagic.com'
    that.is_wizard = true
    that.is_master_wizard = true
  end
  if ['torsten@berlinmagic.com', 'marco@berlinmagic.com',"pernerpatrick@gmail.com"].include?(that.email)
    that.is_wizard = true
  end

  if usr[:pic] && !usr[:pic].blank?
    image_path = Rails.root.join('seed', 'user_pix', "#{ usr[:pic] }.jpg").to_s
    uploaded_image = uploader.fetch_file( image_path )
    # crop = usr[:crop] && !usr[:crop].blank? ? usr[:crop] : nil
    that.image = uploaded_image
  end

  that.save

  puts "*** #{ usr[:first_name].to_s } #{ usr[:name].to_s }"

end
puts "..."
puts "INFO: finished USERS: #{ User.all.count }"
puts "..."
puts ".."
puts "."



# => puts ".."
# => puts "..."
# => puts "Build Questions"
# => puts "..."
# => 
# => 
# => 
# => User.all.each do |usr|
# =>   
# =>   usr.questions.create!(
# =>     text:     "Wofür steht Mexico?",
# =>     answer1:  "Maultaschen",
# =>     answer2:  "Mangos",
# =>     answer3:  "Mayas",
# =>     result:   3
# =>   )
# =>   usr.questions.create!(
# =>     text:     "Wie viele Tage hat ein Jahr?",
# =>     answer1:  "365",
# =>     answer2:  "366",
# =>     answer3:  "356",
# =>     result:   1
# =>   )
# =>   usr.questions.create!(
# =>     text:     "Mit welcher Einheit wird elektrische Spannung gemessen?",
# =>     answer1:  "Watt",
# =>     answer2:  "Ampere",
# =>     answer3:  "Volt",
# =>     result:   3
# =>   )
# =>   usr.questions.create!(
# =>     text:     "Wie viele Nullen hat eine Billiarde?",
# =>     answer1:  "12",
# =>     answer2:  "15",
# =>     answer3:  "18",
# =>     result:   2
# =>   )
# =>   
# => end
# => 
# => puts "..."
# => puts "INFO: finished Questions: #{ Question.all.count }"
