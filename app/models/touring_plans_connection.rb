require 'logger'
require 'faraday'
# we need a 3rd-party extension for some extra middleware:
require 'faraday_middleware'

class TouringPlansConnection
  attr_accessor :connection

  conn = Faraday.new('https://touringplans.com') do |c|
    c.use FaradayMiddleware::ParseJson,       content_type: 'application/json'
    c.use Faraday::Response::Logger,          Logger.new('faraday.log')
    c.use FaradayMiddleware::FollowRedirects, limit: 3
    c.use Faraday::Response::RaiseError       # raise exceptions on 40x, 50x responses
    c.use Faraday::Adapter::NetHttp
  end

  conn.headers[:user_agent] = 'MyLib v1.2'

  CONNECTION = conn
  DEFAULT_QUERY   = {}
  # response = conn.get '/repos/technoweenie/faraday'
  # response.body['issues_count']  #=> 8
  def initialize(options = {})
    @connection       = options.fetch(:connection, CONNECTION)
    @query            = options.fetch(:query, DEFAULT_QUERY)
  end

  def title
    "i am touring plans"
  end
  
  def query(params={})
    @query.update(params)
  end
  
end
