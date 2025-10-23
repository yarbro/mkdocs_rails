# frozen_string_literal: true

module MkdocsRails
  module Config
    DEFAULTS = {
      docs_root: "docs",
      port: 8000,
      enabled: true
    }.freeze

    class << self
      attr_writer :docs_root, :port, :enabled

      def setup
        yield self
      end

      def docs_root
        @docs_root ||= defined?(Rails) ? Rails.root.join(DEFAULTS[:docs_root]) : DEFAULTS[:docs_root]
      end

      def port
        @port ||= DEFAULTS[:port]
      end

      def enabled
        if @enabled.nil?
          defined?(Rails) ? (Rails.env.development? || Rails.env.test?) : DEFAULTS[:enabled]
        else
          @enabled
        end
      end
    end

    @docs_root = nil
    @port = DEFAULTS[:port]
    @enabled = nil
  end
end
