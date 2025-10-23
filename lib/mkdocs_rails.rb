# frozen_string_literal: true

require_relative "mkdocs_rails/version"
require "mkdocs_rails/config"
require "mkdocs_rails/engine"
require "mkdocs_rails/proxy_client"

module MkdocsRails
  class Error < StandardError; end
end
