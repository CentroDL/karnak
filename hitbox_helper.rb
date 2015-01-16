module HitboxHelper
  def get_streams(game)
    media = JSON.parse HTTParty.get "http://api.hitbox.tv/media"
    media["livestream"].select { |x| x["category_name"] == game }
  end
end
