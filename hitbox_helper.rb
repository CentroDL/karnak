module HitboxHelper
  def self.get_streams_api(game)
    media = JSON.parse HTTParty.get "http://api.hitbox.tv/media"
    media["livestream"].select { |x| x["category_name"] =~ /#{game}/i }
  end

  def self.stream_hash(game, stream_data)
    {
      network: "HitBox",
      game:    game,
      viewer_count: stream_data["category_viewers"],
      channel_name: stream_data["channel"]["user_name"],
      channel_embed_url: "http://hitbox.tv/#!/embed/#{stream_data["channel"]["user_name"]}",
      embed_height: 368,
      embed_width:  640
    }
  end

  def self.streams(game)
    streams_data = get_streams_api(game)
    streams_data.map {|stream_data| stream_hash(game, stream_data)}
  end
end
