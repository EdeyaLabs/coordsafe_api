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

    def locate
      response = self.class.get("#{locator_endpoint}/#{URI.escape(company_name)}?key=#{secret}")
    end

    # opts: locator_id, date_from, date_to
    # If only date_from exists,
    def locate_history(locator_id, date_from, date_to=nil)
      if date_to.nil?
        response = self.class.get("#{single_history_endpoint}/#{locator_id}/#{Locator.parameterize(date_from)}?key=#{secret}")
      else
        response = self.class.get("#{history_endpoint}/#{locator_id}/#{Locator.parameterize(date_from, date_to)}?key=#{secret}")
      end
    end

    def self.parameterize(date_from, date_to=nil)
      unless date_to.nil?
        URI.escape("#{date_from.strftime("%m-%d-%Y %H:%M")},#{date_to.strftime("%m-%d-%Y %H:%M")}")
      else
        URI.escape(date_from.strftime("%m-%d-%Y %H:%M"))
      end
    end
  end
end
