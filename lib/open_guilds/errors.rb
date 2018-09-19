module OpenGuilds
  class Error < StandardError
    attr_reader :message

    # Response contains a OpenGuilds::Response object that has some basic information
    # about the response that conveyed the error.
    attr_accessor :response

    attr_reader :code
    attr_reader :http_body
    attr_reader :http_headers
    attr_reader :http_status
    attr_reader :json_body # equivalent to #data
    attr_reader :request_id

    # Initializes a Error.
    def initialize(message = nil, http_status: nil, http_body: nil, json_body: nil,
                   http_headers: nil, code: nil)
      @message = message
      @http_status = http_status
      @http_body = http_body
      @http_headers = http_headers || {}
      @json_body = json_body
      @code = code
      @request_id = @http_headers[:request_id]
    end

    def to_s
      status_string = @http_status.nil? ? "" : "(Status #{@http_status}) "
      id_string = @request_id.nil? ? "" : "(Request #{@request_id}) "
      "#{status_string}#{id_string}#{@message}"
    end
  end

  class AuthorizationError < Error
  end

  class AuthenticationError < Error
  end

  class APIError < Error
  end

  class MissingParametersError < Error
  end

  class InvalidParametersError < Error
  end

  class APIKeyNotSet < Error
  end

  class APIKeyIncorrect < Error
  end
end
