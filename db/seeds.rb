# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

r_and_d = [true, false]

user = User.new(email: "sdafsddx@seeder.com", password: "seedpassword")
user.save!

client = Yelp::Client.new({ consumer_key: ENV['CONSUMER_KEY'],
                            consumer_secret: ENV['CONSUMER_SECRET'],
                            token: ENV['TOKEN'],
                            token_secret: ENV['TOKEN_SECRET']
                          })


result = client.search('chinatown, ma' , { term: 'chinese' })
result = JSON.parse(result.to_json)
business_info = result['businesses']
business_info.each do |business|
  puts business['name']
  Shop.find_or_create_by!(
    name: "#{business['name']}", street_address: "#{business["location"]['address'][0]}",
    city: "#{business["location"]['city']}", state: "Massachusetts",
    zip_code: "#{business["location"]['postal_code']}", description: "#{business["snippet_text"]}",
    phone: "#{business["display_phone"]}", reservations: r_and_d.sample, delivery: r_and_d.sample,
    photo: "#{business["image_url"]}"
  )
end
