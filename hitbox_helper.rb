module HitboxHelper
  def self.get_streams_api(game)
    media = JSON.parse HTTParty.get "http://api.hitbox.tv/media"
    media["livestream"].select { |x| x["category_name"] =~ /#{game}/i }
  end

  def self.stream_hash(game, stream_data)
    {
      network: "hitbox",
      game:    stream_data["category_name"],
      viewer_count: stream_data["category_viewers"],
      channel_name: stream_data["media_status"],
      channel_thumb: "http://edge.sf.hitbox.tv#{stream_data["media_thumbnail"]}",
      streamer_name: stream_data["channel"]["user_name"],
      streamer_logo: "http://edge.sf.hitbox.tv#{stream_data["channel"]["user_logo"]}"
    }
  end

  def self.streams(game)
    streams_data = get_streams_api(game)
    streams_data.map {|stream_data| stream_hash(game, stream_data)}
  end

  def self.get_stream(user)
    data = JSON.parse HTTParty.get "http://api.hitbox.tv/media"
    target_data= data["livestream"].select {|x| x["channel"]["user_name"]== user}
    {
      channel_embed_url: "http://hitbox.tv/#!/embed/#{target_data[0]["channel"]["user_name"]}",
      embed_height: 368,
      embed_width:  640
    }
  end
end
