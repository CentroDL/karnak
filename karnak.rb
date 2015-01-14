module Karnak
	class Server < Sinatra::Base
		
		configure :development do
			register Sinatra::Reloader
			$db = Redis.new
		end

		get '/' do
			top_games_url = "https://api.twitch.tv/kraken/games/top?limit=10&offset=0"
			top_games_hash = HTTParty.get top_games_url
			@top_ten = top_games_hash["top"].select { |x| x }
			erb :index
		end
	end
end