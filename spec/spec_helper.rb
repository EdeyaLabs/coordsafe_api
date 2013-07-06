$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), "..", "lib"))

require 'rspec'
require 'coveralls'
require 'coordsafe_api'
require 'webmock/rspec'

Coveralls.wear!
