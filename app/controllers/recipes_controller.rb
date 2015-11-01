class RecipesController < ApplicationController
  before_action :set_recipe, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, only: [:new,:edit,:update,:destroy,:create]
  # GET /recipes
  # GET /recipes.json
  def index
    if search_params?
      @recipes = Recipe.search(search_params).paginate(per_page:12, page: params[:page])  
    else
      @recipes = Recipe.all.paginate(per_page:8, page: params[:page]) 
    end
  end


  # GET /recipes/1
  # GET /recipes/1.json
  def show
  end

  # GET /recipes/new
  def new
    @recipe = Recipe.new
  end

  # GET /recipes/1/edit
  def edit
  end

  # POST /recipes
  # POST /recipes.json
  def create
    @recipe = Recipe.new(recipe_params)

    respond_to do |format|
      if @recipe.save
        format.html { redirect_to @recipe, notice: 'Recipe was successfully created.' }
        format.json { render :show, status: :created, location: @recipe }
      else
        format.html { render :new }
        format.json { render json: @recipe.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /recipes/1
  # PATCH/PUT /recipes/1.json
  def update
    respond_to do |format|
      if @recipe.update(recipe_params)
        format.html { redirect_to @recipe, notice: 'Recipe was successfully updated.' }
        format.json { render :show, status: :ok, location: @recipe }
      else
        format.html { render :edit }
        format.json { render json: @recipe.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /recipes/1
  # DELETE /recipes/1.json
  def destroy
    @recipe.destroy
    respond_to do |format|
      format.html { redirect_to recipes_url, notice: 'Recipe was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_recipe
      @recipe = Recipe.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def recipe_params
      params.require(:recipe).permit(:title, :cooking_time, :difficulty_level, :food_type_id, :food_preference_id, :cuisine_id, :ingredients, :procedure)
    end
  def search_params?
    params[:food_type] || params[:food_preference] || params[:cuisine] || params[:difficulty]
  end

  def search_params
    query = {}
    query[:food_type_id] = params[:food_type] if params[:food_type]
    query[:food_preference_id] = params[:food_preference] if params[:food_preference]
    query[:cuisine_id] = params[:cuisine] if params[:cuisine]
    query[:difficulty_level] = params[:difficulty] if params[:difficulty]
    return query
  end
end
