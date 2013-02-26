# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
pic_urls = %w(http://img3.etsystatic.com/000/0/6520333/il_340x270.337869715.jpg 
  http://img2.etsystatic.com/000/0/6470079/il_340x270.307745430.jpg 
  http://img2.etsystatic.com/000/0/5772641/il_340x270.346507814.jpg 
  http://img2.etsystatic.com/012/0/5686478/il_170x135.412547510_9ylp.jpg 
  http://img3.etsystatic.com/004/2/5816574/il_170x135.394747515_cizf.jpg 
  http://img3.etsystatic.com/008/0/5419749/il_170x135.366947535_piks.jpg 
  http://img2.etsystatic.com/000/0/5711631/il_170x135.172601594.jpg 
  http://img2.etsystatic.com/016/0/5510827/il_170x135.430561582_sjla.jpg 
  http://img2.etsystatic.com/008/0/7036432/il_170x135.393916306_5juu.jpg 
  http://img2.etsystatic.com/000/0/5601736/il_170x135.301538842.jpg 
  http://img0.etsystatic.com/005/1/6193928/il_170x135.389699944_dozl.jpg 
  http://img1.etsystatic.com/003/0/5224227/il_170x135.361184789_jdpy.jpg 
  http://img1.etsystatic.com/000/0/5412668/il_170x135.278663013.jpg 
  http://img3.etsystatic.com/000/0/6444955/il_170x135.322076231.jpg 
  http://img0.etsystatic.com/000/0/5214462/il_170x135.192312508.jpg
  )

colors = %w(red green blue orange pink turquoise)
categories = %w(Art Jewelry Women Men Vintage Kids)

(pic_urls.length - 1).times do |i|
  # Add one so there is no #Item 0
  name = "Item #{i+1}"

  # Add one so there is no free item
  price_num = ((i+1)*2).to_s
  full_price = "#{price_num}.00"

  # Use rand to select categories and colors at random 
  rando_color = rand(colors.length)
  color = colors[rando_color]
  rando_cat = rand(categories.length)
  category = categories[rando_cat]

  picture_url = pic_urls[i]

  Gift.create(name: name, 
              price: full_price, 
              color: color, 
              picture_url: picture_url,
              category: category)
end

