
require_relative '../../config/environment'

class ApplicationController < Sinatra::Base


  set :method_override, true # This is so Sinatra can read the input tag in html that is either a PATCH, PUT or DELETE

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/' do # root directory

  end

  post '/articles' do # Creates and saves data to database and redirects
    title = params[:title]
    content = params[:content]
    article = Article.create(title: title, content: content)
    redirect "/articles/#{article.id}" #redirects to the '/articles/:id'
  end

  get '/articles' do # Shows all articles in database /renders the index.erb file
    @articles = Article.all
    erb :index
  end

  get '/articles/new' do # Renders the form 
    erb :new
  end
   
  get '/articles/:id' do # Shows the instance that corresponds to the  'id' / renders the show.erb page
    id = params[:id]
    @article = Article.find(id)
    erb :show
  end

  get '/articles/:id/edit' do # Renders the form so we can edit our Article
    id = params[:id]
    @article =  Article.find(id) #we find the article that will need to be updated
    erb :edit
  end

  patch '/articles/:id' do
    article = Article.find(params[:id]) 
    title = params[:title]
    content = params[:content]
    article.update(title: title, content: content)
    redirect "/articles/#{article.id}"
  end

  delete '/articles/:id' do
    id = params[:id]
    article = Article.find(id)
    article.destroy
    redirect '/articles'
  end


 



end
