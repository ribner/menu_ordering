

r_and_d = [true, false]

email = ["fsass@seed.com", "bssdsa@seed.com" , "ffsdsdsdsdra@seed.com", "nsewsdd@seed.com", "newsds@seed.com", "nswsdsd@seed.com"]
email.each do |mail|
  user = User.new(email: mail , password: "seedpassword")
  user.save!
end

client = Yelp::Client.new({ consumer_key: ENV['CONSUMER_KEY'],
                            consumer_secret: ENV['CONSUMER_SECRET'],
                            token: ENV['TOKEN'],
                            token_secret: ENV['TOKEN_SECRET']
                          })


result = client.search('Boston, ma' , { term: 'restaurant' })
result = JSON.parse(result.to_json)
business_info = result['businesses']
business_info.each do |business|
  puts business['name']
  Shop.find_or_create_by!(
    name: business['name'],
    street_address: business["location"]['address'][0],
    city: business["location"]['city'],
    state: "Massachusetts",
    zip_code: business["location"]['postal_code'],
    description: business["snippet_text"],
    phone: business["display_phone"],
    reservations: r_and_d.sample,
    delivery: r_and_d.sample,
    yelp_photo: business["image_url"]
  )
end

MENU_ITEMS = ["pasta", "pizza", "chicken parm", "gumbo shrimp", "garden salad", "pizza", "steak", "burger"]

MENU_ITEMS.each do |item|
  price = (8..20).to_a.sample
  cost = (3..(price / 2).floor).to_a.sample
  Item.create(
    shop_id: 1,
    name: item,
    description: "beef vermicelli with snipata sauce covered in a spicy aflredo tamato with milk cheese",
    price: price,
    cost: cost
  )
end

USER_IDS = [2 ,3 ,4]
TABLES = [1, 2, 3, 4, 5]

shop = Shop.find(1)
USER_IDS.each do |uid|
  user = User.find(uid)
  (1..10).each do |i|
    order_time = i.days.ago
    order = Order.create(
      user_id: 2,
      shop: shop,
      table_number: TABLES.sample,
    )
    item_count = (4..8).to_a.sample
    item_count.times do |item_number|
      item = shop.items.sample
      orderjoin = Orderjoin.create(
        item: item,
        order: order
      )
    order.created_at = order_time
    orderjoin.created_at = order_time
    order.save
    orderjoin.save
    puts orderjoin.created_at
    end
    puts order.created_at
  end
end


