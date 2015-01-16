require 'redis'
require 'sinatra/base'
require 'sinatra/contrib'
require 'sinatra/reloader'
require 'httparty'
require 'uri'
# require 'pry'

require_relative 'hitbox_helper'
require_relative 'twitch_helper'

require_relative 'server'

include HitboxHelper
include TwitchHelper

binding.pry
