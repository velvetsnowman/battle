require 'sinatra/base'
require './lib/player.rb'
require './lib/game.rb'

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
    @player_1 = Player.new(params[:player_1_name])
    @player_2 = Player.new(params[:player_2_name])
    $game = Game.new(@player_1, @player_2)
    redirect '/play'
  end

  get '/play' do
    @game = $game
    erb :play
  end

  post '/attack' do
    $game.attack($game.opponent_of($game.current_turn))
    if $game.game_over?
      redirect '/game-over'
    else
      redirect '/attack'
    end
  end

  get '/attack' do
    @game = $game
    erb :attack
  end

  post '/switch-turns' do
    $game.switch_turns
    redirect('/play')
  end

  get '/game-over' do
    @game = $game
    erb :game_over
  end

end
