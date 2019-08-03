require_relative 'avatars_service'
require_relative 'externals'

class HtmlDemo

  def initialize
    externals = Externals.new
    @avatars = AvatarsService.new(externals)
  end

  def html
    src = ''
    src += sha
    src += alive?
    src += ready?
  end

  private

  attr_reader :avatars

  def sha
    duration,result = timed { avatars.sha }
    pre('sha', duration, 'LightGreen', result)
  end

  def alive?
    duration,result = timed { avatars.alive? }
    pre('alive?', duration, 'LightGreen', result)
  end

  def ready?
    duration,result = timed { avatars.ready? }
    pre('ready?', duration, 'LightGreen', result)
  end

  def timed
    started = Time.now
    result = yield
    finished = Time.now
    duration = '%.4f' % (finished - started)
    [duration,result]
  end

  def pre(name, duration, colour = 'white', result = nil)
    border = 'border: 1px solid black;'
    padding = 'padding: 5px;'
    margin = 'margin-left: 30px; margin-right: 30px;'
    background = "background: #{colour};"
    whitespace = "white-space: pre-wrap;"
    html = "<pre>/#{name}(#{duration}s)</pre>"
    unless result.nil?
      html += "<pre style='#{whitespace}#{margin}#{border}#{padding}#{background}'>" +
              "#{JSON.pretty_unparse(result)}" +
              '</pre>'
    end
    html
  end

end

puts HtmlDemo.new.html
