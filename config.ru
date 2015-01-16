require 'redis'
require 'sinatra/base'
require 'sinatra/contrib'
require 'sinatra/reloader'
require 'httparty'
require 'uri'
require 'pry'

require_relative 'server'

run Karnak::Server
