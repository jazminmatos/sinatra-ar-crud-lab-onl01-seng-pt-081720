
require_relative '../../config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/articles' do
    @articles = Article.all #using ActiveRecord to grab all of the articles

    erb :index
  end

  get '/articles/new' do
    erb :new
  end

  post '/articles' do
    @article = Article.create(params) #using ActiveRecord to grab all of the articles
    
    redirect to "/articles/#{@article.id}"
  end

  get '/articles/:id' do
    @article = Article.find(params[:id])

    erb :show
  end

  get '/articles/:id/edit' do
    @article = Article.find(params[:id])
    
    erb :edit
  end

  patch '/articles/:id' do
    @article = Article.find(params[:id]) #search for the article
    @article.update(title: params[:title], content: params[:content]) #update the article based on input from form
    redirect to "/articles/#{@article.id}"
  end

  delete '/articles/:id' do
    #binding.pry
    Article.delete(params[:id])
  
    redirect to '/articles'
  end
end