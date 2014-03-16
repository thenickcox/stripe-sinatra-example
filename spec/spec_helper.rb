require File.expand_path '../../app.rb', __FILE__

ENV['RACK_ENV'] = "test"

require 'rspec'
require 'capybara/rspec'
require 'rack/test'
require 'capybara/poltergeist'

require 'webmock/rspec'

set :environment, :test
set :run, false
set :logging, false

Capybara.app = App

module RSpecMixin
  def app
    App
  end
end

RSpec.configure do |config|
  config.color_enabled = true
  config.tty = true
  config.formatter = :documentation
  config.include Rack::Test::Methods
  config.include RSpecMixin
end
