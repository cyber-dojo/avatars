# frozen_string_literal: true

require_relative 'http_json/request_error'
require_relative 'http_json_args'
require 'json'
require 'rack'

class RackDispatcher

  def initialize(avatars)
    @avatars = avatars
  end

  def call(env, request_class = Rack::Request)
    request = request_class.new(env)
    path = request.path_info
    body = request.body.read
    name,args = HttpJsonArgs.new(body).get(path)
    @avatars.public_send(name, *args)
  rescue HttpJson::RequestError => error
    json_error_response(400, path, body, error)
  rescue Exception => error
    json_error_response(500, path, body, error)
  end

  private

  def json_error_response(status, path, body, error)
    json = diagnostic(path, body, error)
    body = JSON.pretty_generate(json)
    $stderr.puts(body)
    $stderr.flush
    [ status,
      { 'Content-Type' => 'application/json' },
      [ body ]
    ]
  end

  # - - - - - - - - - - - - - - - -

  def diagnostic(path, body, error)
    { 'exception' => {
        'path' => path,
        'body' => body,
        'class' => 'AvatarsService',
        'message' => error.message,
        'backtrace' => error.backtrace
      }
    }
  end

end
