require 'nokogiri'
require 'open-uri'
require 'mechanize'

class DfbConnection
  attr_accessor :connection, :query, :base_uri
  CONNECTION          = Mechanize.new
  BASE_URI            = "http://www.disneyfoodblog.com"
  DEFAULT_QUERY       = {}
  
  def initialize(options = {})
    @connection       = options.fetch(:connection, CONNECTION)
    @query            = options.fetch(:query, DEFAULT_QUERY)
    @base_uri         = BASE_URI
  end
  
  def title
    "i am dfb_connection"
  end
  
  def connect(http_method: "get", relative_path: "/")
    response  = connection.get("#{base_uri}#{relative_path}")
    result    = response.parser.css('div.entry-content')
  end
  
end
