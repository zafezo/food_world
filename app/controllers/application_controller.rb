class ApplicationController < ActionController::Base
 before_filter :siderbar_values, except: [:login, :logout]

  def siderbar_values
  	@food_preferences = FoodPreference.all.limit(10)
  	@food_types = FoodType.all.limit(10)
  	@cuisines = Cuisine.all
  end
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
 
end
