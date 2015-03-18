module Karnak
  class Server < Sinatra::Base

    $twitch_error = false

    configure :development do
      require 'pry'
      register Sinatra::Reloader
      $db = Redis.new
    end

    get '/' do
      top_games_url  = "https://api.twitch.tv/kraken/games/top?limit=12"
      top_games_hash = HTTParty.get top_games_url
      @top_games     = top_games_hash["top"]
      erb :index
    end

    get '/games/:name' do
      # get network feeds
      @game = params[:name]

      @twitch_streams = TwitchHelper.streams @game
      @hitbox_streams = HitboxHelper.streams @game

      # merge all network feeds
      @streams = @twitch_streams | @hitbox_streams
      limit    = params[:limit] || 24
      offset   = params[:start] || 0
      @streams = @streams[(offset.to_i)..-1].take(limit.to_i)
      erb :games
    end

    post '/games' do
      query = URI.escape(params[:game])
      redirect "/games/#{query}"
    end

    get '/about' do
      erb :about
    end

    get '/stream/twitch/:id' do
      @stream = TwitchHelper.get_stream(params[:id])
      erb :stream
    end

    get '/stream/hitbox/:id' do
      @stream = HitboxHelper.get_stream(params[:id])
      erb :stream
    end

  end#Server
end#Karnak
