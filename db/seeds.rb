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
  http://img0.etsystatic.com/005/0/5297867/il_170x135.386521924_azcq.jpg 
  http://img0.etsystatic.com//000//0//6389534//il_170x135.255346176.jpg 
  http://img3.etsystatic.com//014//0//7663021//il_170x135.426163355_n351.jpg 
  http://img3.etsystatic.com//000//0//6404355//il_170x135.312227543.jpg 
  http://img0.etsystatic.com//015//0//7245190//il_170x135.426469612_3o1i.jpg 
  http://img0.etsystatic.com//001//0//5413874//il_170x135.361627696_n9mu.jpg 
  http://img0.etsystatic.com//000//0//5892479//il_170x135.310157472.jpg 
  http://img3.etsystatic.com//000//0//5630827//il_170x135.254208351.jpg 
  http://img1.etsystatic.com//009//0//6540783//il_170x135.425193361_67je.jpg 
  http://img3.etsystatic.com//010//0//7586293//il_170x135.433664595_thlw.jpg 
  http://img1.etsystatic.com//000//0//5415342//il_170x135.180239949.jpg 
  http://img2.etsystatic.com//000//0//5415342//il_170x135.180239950.jpg 
  http://img0.etsystatic.com//000//0//6447052//il_170x135.314938784.jpg 
  http://img1.etsystatic.com//003//0//6259507//il_170x135.404842013_hiwf.jpg 
  http://img3.etsystatic.com//016//0//7062308//il_170x135.416047487_fgjm.jpg 
  http://img0.etsystatic.com//011//0//6422849//il_170x135.422050164_euau.jpg 
  http://img3.etsystatic.com//000//0//6447052//il_170x135.283844095.jpg
  )

colors = %w(red green blue orange pink turquoise)
categories = %w(Art Jewelry Women Men Vintage Kids)

(pic_urls.length - 1).times do |i|
  # Add one so there is no #Item 0
  name = "Item #{i+1}"

  # Add one so there is no free item
  price = ((i+1)*200)

  # Use rand to select categories and colors at random 
  color = colors.sample
  category = categories.sample

  picture_url = pic_urls[i]

  Gift.create(name: name, 
              price: price, 
              color: color, 
              picture_url: picture_url,
              category: category)
end

