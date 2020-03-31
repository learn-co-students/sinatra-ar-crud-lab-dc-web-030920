
require_relative '../../config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/' do

  end

  get '/articles/new' do
    #renders the new.erb view
    erb :new
  end

  get '/articles' do
    #grab all articles and store them in instance variables
    @articles = Article.all
    # binding.pry
    erb :index
  end

  post '/articles' do
    title = params[:title]
    content = params[:content]
    article = Article.create(title: title, content: content)
    redirect "/articles/#{article.id}"
  end

  get '/articles/:id/edit' do
    id = params[:id]
    @article = Article.find(id)
    erb :edit
  end
  
  get '/articles/:id' do
    id = params[:id]
    @article = Article.find(id)
    
    erb :show
  end

  patch '/articles/:id' do
    article = Article.find(params[:id])
    content = params[:content]
    title = params[:title]
    article.update(title: title, content: content)
    redirect "/articles/#{article.id}"
  end

  delete "/articles/:id" do 
    @article = Article.find(params[:id])
    @article.destroy 
    redirect "/articles"
end

end
# Create the get '/articles/:id' controller action. This action should use Active Record to grab the 
# article with the id that is in the params and set it equal to @article. Then, it should render the 
# show.erb view page. That view should use ERB to render the @article's title and content.