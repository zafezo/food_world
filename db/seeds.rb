# # This file should contain all the record creation needed to seed the database with its default values.
# # The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).

food_types = ["Curry", "Dessert","Sides","Breakfast"]
food_types.each { |e| FoodType.where(name: e).first_or_create  }

food_preferences = ["Vegetarian","Vegan", "Meat", "Dairy"]
food_preferences.each { |e| FoodPreference.where(:name => e).first_or_create }

cuisines = ["Italian", "Mexican", "Indian","Chinese"]
cuisines.each{|d| Cuisine.where(name: d).first_or_create}

4.times {
	15.times{
		title  = Faker::Lorem.sentence(3)		
		r = Recipe.where(title: title).first_or_create
		cooking_time =  ''+ (rand(3)+1).to_s + 'h'
		difficulty_level = Recipe::DIFFICULTY.at(rand(3))
		food_type_id = rand(4) +1
		food_preference_id = rand(4)+1
		cuisine_id = rand(4)+1
		ingredients = Faker::Lorem.paragraph(2, true, 4)
		procedure = Faker::Lorem.paragraph(2, true, 4)
		r.update(cooking_time: cooking_time,
				difficulty_level: difficulty_level,
					food_type_id: food_type_id,
					food_preference_id: food_preference_id,
					cuisine_id:cuisine_id,
					ingredients: ingredients,
					procedure: procedure)
	}

 }
# Recipe.delete_all