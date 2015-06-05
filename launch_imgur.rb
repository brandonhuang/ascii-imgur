require 'pry'
require 'open-uri'
require 'nokogiri'
require 'asciiart'
require 'require_all'
require_all './lib'

Interface.new(Imgur.new).browse("r")