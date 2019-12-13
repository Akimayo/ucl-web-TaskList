namespace :generate do
    task test_data: :environment do
        if User.where(email: "shrek@farfaraway.swamp").count > 0
            puts "Bulk test user already exists"
            return
        end
        puts "Creating bulk test data - this could take a while"
        usr = User.create!(email: "shrek@farfaraway.swamp", password: "onions4life", password_confirmation: "onions4life", username: "shrek_the_ogre")
        20.times do |i|
            # Generate categories
            usr.categories.new(title: "Category #{i}", color: "#BADA55")
            if i % 10 == 9 then puts "#{i+1}/20C" end
        end
        usr.save!
        50.times do |i|
            # Generate tags
            usr.tags.new(title: "Tag #{i}", color: "#4525AA")
            if i % 10 == 9 then puts "#{i+1}/50G" end
        end
        usr.save!
        400.times do |i|
            # Generate tasks
                # FLAGS:
                # X__ DONE
                # _X_ CATEGORY
                # __X TAG
            flags = rand(0..7)
            if flags & 4 > 0 then m_done = true
            else m_done = false end
            if flags & 2 > 0 then m_category = usr.categories[rand(usr.categories.count)]
            else m_category = nil end
            m_tags = []
            if flags & 1 > 0
                rand(1..10).times do |n|
                    m_tags << usr.tags[rand(usr.tags.count)]
                end
            end
            usr.tasks.new(title: "Task #{i}", is_done: m_done, category: m_category, tags: m_tags)
            if i % 10 == 9 then puts "#{i+1}/400T" end
        end
        usr.save!
        puts "Test data creation finished"
        unless usr.id.nil? then puts "Login with e-mail `shrek@farfaraway.swamp` and password `onions4life`" end
    end
end
