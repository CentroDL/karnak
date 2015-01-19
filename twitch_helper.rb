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
      game:         stream_data["game"],
      viewer_count: stream_data["viewers"],
      embed_height: 378,
      embed_width:  620,
      channel_name: stream_data["channel"]["status"],
      channel_thumb: stream_data["preview"]["large"],#consider template wxh
      channel_embed_url: "#{stream_data["channel"]["url"]}/embed",
      streamer_name: stream_data["channel"]["display_name"],
      streamer_logo: stream_data["channel"]["logo"]
    }
  end

  def self.streams(game)
    streams_data = get_streams_api(game)["streams"]
    streams_data.map {|stream_data| stream_hash(game, stream_data)}
  end
end
