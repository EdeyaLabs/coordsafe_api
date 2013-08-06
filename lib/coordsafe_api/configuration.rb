module CoordsafeApi
  module Configuration
    VALID_CONNECTION_KEYS = [:locator_endpoint, :history_endpoint, :single_history_endpoint, :user_agent, :method].freeze
    VALID_OPTIONS_KEYS    = [:secret, :company_name, :format].freeze
    VALID_CONFIG_KEYS     = VALID_CONNECTION_KEYS + VALID_OPTIONS_KEYS

    DEFAULT_LOCATOR_ENDPOINT        = "http://www.coordsafe.com.sg/geoready/api/locator/company"
    DEFAULT_HISTORY_ENDPOINT        = "http://www.coordsafe.com.sg/geoready/api/history"
    DEFAULT_SINGLE_HISTORY_ENDPOINT = "http://www.coordsafe.com.sg/geoready/api/location"
    DEFAULT_METHOD                  = :get
    DEFAULT_USER_AGENT              = "CoordsafeApi Ruby Gem #{CoordsafeApi::VERSION}".freeze

    DEFAULT_KEY          = nil
    DEFAULT_COMPANY_NAME = nil
    DEFAULT_FORMAT       = :json

    attr_accessor *VALID_CONFIG_KEYS

    def self.extended(base)
      base.reset
    end

    def configure
      yield self
    end

    def reset
      self.locator_endpoint        = DEFAULT_LOCATOR_ENDPOINT
      self.history_endpoint        = DEFAULT_HISTORY_ENDPOINT
      self.single_history_endpoint = DEFAULT_SINGLE_HISTORY_ENDPOINT
      self.method                  = DEFAULT_METHOD
      self.user_agent              = DEFAULT_USER_AGENT

      self.secret       = DEFAULT_KEY
      self.company_name = DEFAULT_COMPANY_NAME
      self.format       = DEFAULT_FORMAT
    end

    def options
      Hash[ * VALID_CONFIG_KEYS.map { |key| [key, send(key)] }.flatten ]
    end
  end
end
