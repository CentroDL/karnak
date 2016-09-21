module TwitchHelper

  def self.get_streams_api(game)
    media = "https://api.twitch.tv/kraken/search/streams?" +
            (URI.encode_www_form "q" => game)
    HTTParty.get media
  end

  def self.stream_hash(game, stream_data)
    {
      network:       "twitch",
      game:          stream_data["game"],
      viewer_count:  stream_data["viewers"],
      channel_name:  stream_data["channel"]["status"],
      channel_thumb: stream_data["preview"]["medium"],#consider template wxh
      streamer_name: stream_data["channel"]["display_name"],#used to get stream
      streamer_logo: stream_data["channel"]["logo"]
    }
  end

  def self.streams(game)

    streams_data = get_streams_api(game)

    if streams_data.has_key? 'streams'
      streams_data['streams'].map { |stream_data| stream_hash(game, stream_data) }
    else
      streams_data #if there's an error it'll return the error hash
    end
  end

  def self.get_stream(user)
    data = HTTParty.get "https://api.twitch.tv/kraken/streams/#{user}"
    if data.has_key? 'error'
      data  # gives the error hash back to the view to be displayed, can't do it here
    else
      {
        channel_embed_url: "#{data["stream"]["channel"]["url"]}/embed",
        embed_height:      378,
        embed_width:       620
      }
    end
  end
end
