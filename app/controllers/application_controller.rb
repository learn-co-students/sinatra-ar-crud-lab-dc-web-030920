
require_relative '../../config/environment'


class ApplicationController < Sinatra::Base
  
  set :method_override, true

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/' do
    redirect "/articles"
  end

  get '/articles' do
    @articles = Article.all
    
    erb :index
    # binding.pry
  end

  get '/articles/new' do
    erb :new
  end
  
  get '/articles/:id' do
    @article_id = Article.find(params[:id])
    erb :show
  end


  post '/articles' do 
    @article = Article.create(title: params[:title], content: params[:content])
    
    redirect "/articles/#{@article.id}"
  end

  get '/articles/:id/edit'do
    @article_edit = Article.find(params[:id])
    erb :edit
  end

  patch '/articles/:id' do
    @article_id = Article.find(params[:id])
    @article_id.update(title: params[:title], content: params[:content])  
    @article_id.save
    redirect "/articles/#{@article_id.id}"
  end

  delete '/articles/:id' do

    @article_id = Article.find(params[:id])
    @article_id.destroy
    redirect '/articles'

  end






  
  
end
