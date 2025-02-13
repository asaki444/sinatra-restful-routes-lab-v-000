require 'pry'
class ApplicationController < Sinatra::Base
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

   get '/recipes/new' do
       erb :new
     end


    get '/recipes' do
      @recipes = Recipe.all
      erb :index
    end

    delete '/recipes/:id/delete' do #delete action
      @recipe = Recipe.find_by_id(params[:id])
      @recipe.delete
      redirect to '/recipes'
    end

    post '/recipes' do  #creates a recipe
      @recipe = Recipe.create(params)
      redirect to "/recipes/#{@recipe.id}"
    end

    get '/recipes/:id/edit' do  #load edit form
        @recipe = Recipe.find_by_id(params[:id])
        erb :edit
    end

    get '/recipes/:id' do
      @recipe = Recipe.find_by_id(params[:id])
      erb :show
    end

    patch '/recipes/:id' do #edit action  binding.pry
      @recipe = Recipe.find_by_id(params[:id])
      @recipe.name = params[:name]
      @recipe.ingredients = params[:ingredients]
      @recipe.cook_time = params[:cook_time]
      @recipe.save
      redirect to "/recipes/#{@recipe.id}"
    end

end
