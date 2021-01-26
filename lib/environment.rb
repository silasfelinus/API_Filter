require_relative "./api_filter/version"
require_relative "./api_filter/cli"
require_relative "./api_filter/manager"
require 'pry'
require "httparty"

module API_Filter
  class Error < StandardError; end


end
