require 'redis'
require 'sinatra/base'
require 'sinatra/contrib'
require 'sinatra/reloader'
require 'sinatra/flash'
require 'httparty'
require 'uri'

require_relative 'hitbox_helper'
require_relative 'twitch_helper'

require_relative 'server'

run Karnak::Server
