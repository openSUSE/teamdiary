require 'faker'

namespace :db do
  desc "Fill in with stupid entries"
  task :fill_diary => :environment do
   users = []
   8.times { |i|
     u = User.create(name: Faker::Name.name)
     users[i] = u
   }
   today = Time.now
   100.times { 
     Entry.transaction do
     8.times { |i|
      20.times { 
        e = Entry.new(content: Faker::Lorem.sentence) 
        e.created_at = today
	users[i].entries << e
        e.save
      }
    }
    today = today - 1.day
    end
   }
  end
end

