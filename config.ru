require 'redis'
require 'sinatra/base'
require 'sinatra-contrib'

require_relative 'karnak'

run Karnak::Server