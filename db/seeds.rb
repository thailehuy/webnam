# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# Added by Refinery CMS Pages extension
Refinery::Pages::Engine.load_seed

Refinery::Sites::Engine.load_seed

# Added by Refinery CMS Services Pages extension
Refinery::Sites::Engine.load_seed

# Added by Refinery CMS Coupons Pages extension
Refinery::Sites::Engine.load_seed

# Added by Refinery CMS Coupons extension
Refinery::Sites::Engine.load_seed

# Added by Refinery CMS Blog Posts extension
Refinery::Sites::Engine.load_seed

# Added by Refinery CMS Events extension
Refinery::Sites::Engine.load_seed

# Added by Refinery CMS Product Categories extension
Refinery::Sites::Engine.load_seed

# Added by Refinery CMS Products extension
Refinery::Sites::Engine.load_seed

# Added by Refinery CMS Google Calendars extension
Refinery::Sites::Engine.load_seed
