require_relative "./matchmaker/version"
require_relative "./matchmaker/cli"
require_relative "./matchmaker/matchmaker"
require 'pry'
require "httparty"

module Matchmaker
  class Error < StandardError; end


end
