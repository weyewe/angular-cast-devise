# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

["aww", "nsfw", "MatureWomen", "cougars", "FlashingGirls", 
  "HappyEmbarrassedGirls", "gonewild", "lipsdatgrip", "milf", 
  "Hotchickswithtattoos", "nsfw_gif", "OnOff", 
  "realgirls", "wtf", "legsup", "curvy", "perfectbabes", 
  "toplessamateurs", "juicyasians", "nsfwhardcore", "buttsharpies", 
  "O_Faces", "Orgasms", "ravergirl", "nsfwnew", "cumsluts", "GoneWildPlus", 
  "NSFW_nospam", "voluptuous", "thick", "AsianHotties", "hugeboobs", 
  "Upskirt", "nsfw2", "nsfwoutfits", "collegesluts", "camwhores", 
  "Bondage", "anilingus", "ns4w", "nsfw_young", "genderfuck", "TightShorts", 
  "CollegeAmateurs", "Unashamed", "preggo", "lipsthatgrip", 
  "cumfetish", "MILF", "Girlsontop", "groupsex", "buttsex", "OnlyAnal"]
.each do |x|
  SubReddit.create_object( {
    :name => x,
    :last_viewed_post_name => nil 
  })
end

