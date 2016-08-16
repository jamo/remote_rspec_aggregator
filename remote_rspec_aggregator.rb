require 'bundler'
require 'rack'
Bundler.require(:default)
require 'json'


#$formatter = RSpec::Core::Formatters::ProgressFormatter.new($IO)
before do
  pass unless request.accept? 'application/json'
  request.body.rewind
  body = request.body.read
  @request_payload = body.empty? ? {} : JSON.parse(body)
end


post '/:method.json', provides: :json do
  data = @request_payload
  str = "#{data['status']} - #{data['host']} |  "
  case params['method']
    when 'example_passed'
    str = "#{str} #{data['full_description']}".green
  when 'example_failed'
    str = "#{str} #{data['file_path']}:#{data['line_number']} #{data['exception']}".red
  when 'example_pending'
    str = "#{str} #{data['file_path']}:#{data['line_number']} #{data['exception']}".yellow
  end
  $IO.puts str
end

