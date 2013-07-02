module CoordsafeApi
  module V1
    class Locator
      attr_accessor *CoordsafeApi::Configuration::VALID_CONFIG_KEYS

      def initialize(options={})
        merged_options = CoordsafeApi.options.merge(options)

        CoordsafeApi::Configuration::VALID_CONFIG_KEYS.each do |key|
          send("#{key}=", merged_options[key])
        end
      end

    end
  end
end
