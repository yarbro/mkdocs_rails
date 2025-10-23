# frozen_string_literal: true

module MkdocsRails
  class DocsController < ActionController::Base
    skip_before_action :verify_authenticity_token

    def show
      return render_mkdocs_unavailable unless Config.enabled

      proxy_client = MkdocsRails::ProxyClient.new(port: Config.port)
      path = request.fullpath

      response = proxy_client.get(path)

      send_data response.body,
                type: response["content-type"],
                status: response.code,
                disposition: "inline"
    rescue MkdocsRails::ProxyClient::ConnectionError => e
      render plain: <<~MSG, status: 503
        Could not connect to MkDocs server on localhost:#{Config.port}

        Make sure MkDocs is running:
          bin/docs serve

        Then refresh this page.
      MSG
    rescue StandardError => e
      render plain: "Error proxying to MkDocs: #{e.message}", status: 500
    end

    private

    def render_mkdocs_unavailable
      render plain: <<~MSG, status: 503
        MkDocs Rails is not configured for #{Rails.env} environment.

        In development: Make sure MkDocs is running (bin/docs serve)
        In production: Configure a backend in v0.2.0+
      MSG
    end
  end
end
