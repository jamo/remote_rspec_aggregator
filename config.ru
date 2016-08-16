$IO = $stdout.clone
$stdout.reopen("#{File.dirname(File.realpath(__FILE__))}/log/rack.log")
$stderr.reopen($stdout)
$stdout.sync = true
$stderr.sync = true

require './remote_rspec_aggregator'

log = File.new("access.log", "a+")
log.sync = true
use(Rack::CommonLogger, log)

run Sinatra::Application

