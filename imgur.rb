require 'pry'
require 'open-uri'
require 'nokogiri'
require 'asciiart'

require_relative "classes"

Interface.new(Imgur.create).browse("r")