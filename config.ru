require 'redis'
require 'sinatra/base'
require 'sinatra/contrib'
require 'sinatra/reloader'
require 'httparty'

require_relative 'karnak'

run Karnak::Server