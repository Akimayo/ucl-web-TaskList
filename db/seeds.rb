# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
User.all.each do |usr|
    bell = 7.chr
    puts "Seeding user `#{usr.username}`"
    if usr.tasks.where("title LIKE '#{bell}%'").count > 0 ||
       usr.tags.where("title LIKE '#{bell}%'").count > 0 ||
       usr.categories.where("title LIKE '#{bell}%'").count > 0 then puts "  This user already has some default entities"
    else
        c0 = usr.categories.new({title: "#{bell}Osobní", color: "#FF0000"})
        c1 = usr.categories.new(title: "#{bell}Škola", color: "#00FF00")
        usr.categories.new(title: "#{bell}Práce", color: "#0000FF")
        puts "  Added default categories"
        g1 = usr.tags.new(title: "#{bell}UCL", color: "#F00000")
        usr.tags.new(title: "#{bell}JSE", color: "#0FFFFF")
        g2 = usr.tags.new(title: "#{bell}WEB", color: "#00F000")
        usr.tags.new(title: "#{bell}3DT", color: "#FF0FFF")
        usr.tags.new(title: "#{bell}PR1", color: "#0000F0")
        usr.tags.new(title: "#{bell}PES", color: "#FFFF0F")
        g0 = usr.tags.new(title: "#{bell}Nákupy", color: "#000FFF")
        usr.tags.new(title: "#{bell}Wishlist", color: "#FFF000")
        puts "  Added default tags"
        usr.tasks.new(title: "#{bell}Toto je jednoduchý úkol", is_done: false)
        usr.tasks.new(title: "#{bell}Toto je už dokončený úkol", is_done: true)
        usr.tasks.new(title: "#{bell}Nakoupit na večeři", is_done: false, category: c0, tags: [g0])
        usr.tasks.new(title: "#{bell}Udělat semestrální práci z předmětu WEB", is_done: false, category: c1, tags: [g1, g2])
        puts "  Added default tasks"
        usr.save!
        puts "  Default entities created"
    end
end