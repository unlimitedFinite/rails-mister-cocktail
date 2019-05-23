# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

puts 'Filling database with cocktails'

20.times do
  Cocktail.create(name: Faker::Beer.hop)
end

puts 'Filling database with ingredients'

100.times do
  Ingredient.create(name: Faker::Food.ingredient)
end

puts 'Filling database with doses'

50.times do
  Dose.create(
    description: rand(0..25).to_s + ' ' + Faker::Food.metric_measurement,
    ingredient: Ingredient.all.sample,
    cocktail: Cocktail.all.sample
  )
end

puts 'Finished'
