module CoordsafeApi
  class Locator
    include HTTParty

    attr_accessor *Configuration::VALID_CONFIG_KEYS

    def initialize(options={})
      merged_options = CoordsafeApi.options.merge(options)

      Configuration::VALID_CONFIG_KEYS.each do |key|
        send("#{key}=", merged_options[key])
      end
    end

    # Options
    # locator_id
    # date_from
    # date_to
    # date
    def locate(options = {})
      if options.empty?
        response = self.class.get("#{locator_endpoint}/#{URI.escape(company_name)}?key=#{secret}")
      end
    end
  end
end
