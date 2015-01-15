module Karnak
  class Server < Sinatra::Base

    configure :development do
      register Sinatra::Reloader
      $db = Redis.new
    end

    get '/' do
      top_games_url = "https://api.twitch.tv/kraken/games/top?limit=12&offset=0"
      top_games_hash = HTTParty.get top_games_url
      @top_games = top_games_hash["top"]
      erb :index
    end

    get '/games/:name' do
      game_url = "https://api.twitch.tv/kraken/search/streams?" + URI.encode_www_form({"q" => params[:name]})
      @game = HTTParty.get game_url
      # binding.pry
      erb :game
    end


  end#Server
end#Karnak
