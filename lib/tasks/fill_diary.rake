require 'faker'

namespace :db do
  desc "Fill in with stupid entries"
  task :fill_diary => :environment do
   today = Time.now
   100.times { 
     Entry.transaction do
     8.times { 
      u = User.create(name: Faker::Name.name)
      20.times { 
        e = Entry.new(content: Faker::Lorem.sentence, user: u.name) 
        e.created_at = today
        e.save
      }
    }
    today = today - 1.day
    end
   }
  end
end

