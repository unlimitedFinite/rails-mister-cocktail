# # TO DO :
# Make all data that goes into database be parameterized


require 'json'
require 'open-uri'

start_time = Time.now

puts 'Spilling cocktails...'
Cocktail.destroy_all
puts 'Burning ingredients...'
Ingredient.destroy_all
puts 'Deleting dose information...'
Dose.destroy_all
puts "OK... Filling database with cocktails"

# fetching cocktail seeds
querys = []
all_url = 'https://www.thecocktaildb.com/api/json/v1/1/filter.php?c=Cocktail'
json = open(all_url).read
data = JSON.parse(json)
amount = data['drinks'].length
counter = 0
10.times do
  q = data['drinks'][counter]['strDrink']
  querys << q unless q.include? 'Empell'
  counter += 1
end

puts "Please be patient"

# creating cocktails
query_count = 0
querys.each do |query|
  url = "https://www.thecocktaildb.com/api/json/v1/1/search.php?s="
  search = url + query
  json = open(search).read
  data = JSON.parse(json)
  cocktail = Cocktail.new(
    name: data['drinks'][0]['strDrink'],
    slug_name: data['drinks'][0]['strDrink'].downcase.parameterize,
    description: data['drinks'][0]['strInstructions']
  )
  cocktail.remote_photo_url = data['drinks'][0]['strDrinkThumb']
  cocktail.save
  query_count += 1
  puts "Cocktail number [#{query_count} of #{querys.length}] has been added...."
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
  14.times do
    Dose.create(
      description: data['drinks'][0]["strMeasure#{count}"],
      ingredient: Ingredient.find_by(name: data['drinks'][0]["strIngredient#{count}"]),
      cocktail: cocktail
    )
    count += 1
  end
end

time_taken = Time.now - start_time
puts "Only took #{time_taken / 60} mins.. Wow so fast!"
