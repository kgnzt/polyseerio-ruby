module Polyseerio
  module Constant
    ACCESS_TOKEN_HEADER     = 'X-AUTH-HEADER'.freeze
    DEFAULT_API_BASE_URL    = 'api.polyseer.io/polyseer'.freeze
    DEFAULT_API_PROTOCOL    = 'https://'.freeze
    DEFAULT_API_VERSION     = 'v1'.freeze
    DEFAULT_ENV             = 'RAILS_ENV'.freeze
    DEFAULT_ENVIRONMENT     = 'development'.freeze
    DEFAULT_HEARTBEAT_DELAY = 30_000
    DEFAULT_TIMEOUT         = 10_000
    DEFAULT_TOKEN_ENV       = 'POLYSEERIO_TOKEN'.freeze
  end
end
