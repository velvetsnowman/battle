require 'sinatra/base'

class Battle < Sinatra::Base

  enable :sessions
  #used for storing information between requests
  #a short term information store, lives on a server
  #allows a server to store basic piece of info
  #like a name across multiple requests
  #most often used to store details on a logged in user
  #a session is a HASH


  get '/' do
    erb :index
  end

  post '/names' do
    session[:player_1_name] = params[:player_1_name]
    session[:player_2_name] = params[:player_2_name]
    #here we store the names into the session rather
    #than to an ins.var to be used in a GET
    redirect '/play'
    #we do the above to avoid rendering a view
    #from within a POST.
    #we are redirected to a GET to render our view

  end

  get '/play' do
    @player_1_name = session[:player_1_name]
    @player_2_name = session[:player_2_name]
    erb :play
  end

end
