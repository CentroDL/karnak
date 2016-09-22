# require 'redis'
require 'sinatra/base'
require 'sinatra/contrib'
require 'sinatra/flash'
require 'sinatra/reloader'
require 'httparty'
require 'uri'

require_relative 'hitbox_helper'
require_relative 'twitch_helper'

require_relative 'server'

include HitboxHelper
include TwitchHelper
binding.pry

