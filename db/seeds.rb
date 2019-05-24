# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'json'
require 'open-uri'

puts 'Spilling cocktails...'
Cocktail.destroy_all

puts 'Burning ingredients...'
Ingredient.destroy_all

puts 'Deleting dose information...'
Dose.destroy_all

# creating cocktails
puts 'Filling database with new cocktails'

names = []
url = 'https://www.thecocktaildb.com/api/json/v1/1/filter.php?c=Cocktail'


querys = ['margarita', 'rum', 'whiskey', 'amaretto']
querys.each do |query|
  url = "https://www.thecocktaildb.com/api/json/v1/1/search.php?s="
  search = url + query
  json = open(search).read
  data = JSON.parse(json)
  cocktail = Cocktail.new(
    name: data['drinks'][0]['strDrink'],
    description: data['drinks'][0]['strInstructions']
  )
  cocktail.remote_photo_url = data['drinks'][0]['strDrinkThumb']
  cocktail.save
end

# creating ingredients
puts 'Filling database with ingredients'
url = "https://www.thecocktaildb.com/api/json/v1/1/list.php?i=list"
json = open(url).read
data = JSON.parse(json)
data['drinks'].each do |d|
  Ingredient.create(name: d['strIngredient1'])
end


# creating doses
puts "Assigning ingredients to cocktails"
Cocktail.all.each do |cocktail|
  url = "https://www.thecocktaildb.com/api/json/v1/1/search.php?s=#{cocktail.name}"
  json = open(url).read
  data = JSON.parse(json)
  count = 1
  10.times do
    Dose.create(
      description: data['drinks'][0]["strMeasure#{count}"],
      ingredient: Ingredient.find_by(name: data['drinks'][0]["strIngredient#{count}"]),
      cocktail: cocktail
    )
    count += 1
  end
end

# 50.times do
#   Dose.create(
#     description: rand(1..25).to_s + ' ml',
#     ingredient: Ingredient.all.sample,
#     cocktail: Cocktail.all.sample
#   )
# end

# puts 'Finished'

# # new scraping seed file













