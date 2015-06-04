require 'pry'
require 'open-uri'
require 'nokogiri'
require 'asciiart'

require_relative "classes"

Image.import_imgs
Image.browse("r")