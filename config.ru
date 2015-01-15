require 'redis'
require 'sinatra/base'
require 'sinatra/contrib'
require 'sinatra/reloader'
require 'httparty'
require 'uri'
require 'pry'

require_relative 'karnak'

run Karnak::Server
