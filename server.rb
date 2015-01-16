module Karnak
  class Server < Sinatra::Base

    configure :development do
      require 'pry'
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
      @game = params[:name]

      @twitch_streams = TwitchHelper.streams @game
      @hitbox_streams = HitboxHelper.streams @game

      # merge all network feeds
      @streams = @twitch_streams | @hitbox_streams

      limit = params[:limit] || 6
      start = params[:start] || 0

      # binding.pry

      @streams = @streams[(start.to_i)..-1].take(limit.to_i)

      erb :game
    end

    get '/about' do
      erb :about
    end


  end#Server
end#Karnak
