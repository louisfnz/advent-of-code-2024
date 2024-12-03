# frozen_string_literal: true

ROOT = __dir__

require "bundler/setup"
require "debug"
require "rainbow"

require "./lib/solve"
require "./lib/test"
require "./lib/message"

Dir["./lib/days/*.rb"].each { |f| require f }
Dir["./lib/tests/*.rb"].each { |f| require f }
