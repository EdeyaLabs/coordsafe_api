module CoordsafeApi
  module V1
    class Locator
      # This is really weird, this doesn't work while the
      # reference on the bottom does.
      # attr_accessor *CoordsafeApi::Configuration::VALID_CONFIG_KEYS
      attr_accessor :endpoint, :user_agent, :method, :secret, :company_name, :format


      def initialize(options={})
        merged_options = CoordsafeApi.options.merge(options)

        CoordsafeApi::Configuration::VALID_CONFIG_KEYS.each do |key|
          send("#{key}=", merged_options[key])
        end
      end

    end
  end
end
