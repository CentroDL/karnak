module TwitchHelper
  def self.get_streams_api(game)
    media = "https://api.twitch.tv/kraken/search/streams?" + \
            URI.encode_www_form({
              "q"     => game,
              "limit" => 12
            })
    HTTParty.get media
  end

  def self.stream_hash(game, stream_data)
    {
      network:      "Twitch",
      game:         game,
      viewer_count: stream_data["viewers"],
      channel_name: stream_data["channel"]["display_name"],
      channel_embed_url: "#{stream_data["channel"]["url"]}/embed",
      embed_height: 378,
      embed_width:  620
    }
  end

  def self.streams(game)
    streams_data = get_streams_api(game)["streams"]
    streams_data.map {|stream_data| stream_hash(game, stream_data)}
  end
end
