require 'spec_helper'

describe CoordsafeApi::V1::Locator do
  before do
    @keys = CoordsafeApi::Configuration::VALID_CONFIG_KEYS
  end

  describe "with module configuration" do
    before do
      CoordsafeApi.configure do |config|
        @keys.each do |key|
          config.send("#{key}=", key)
        end
      end
    end

    after do
      CoordsafeApi.reset
    end

    it "should inherit module configuration" do
      api = CoordsafeApi::V1::Locator.new
      @keys.each do |key|
        api.send(key).should eq(key)
      end
    end

    describe "with class configuration" do
      before do
        @config = {
          :secret       => "qwerty",
          :company_name => "qwerty",
          :format       => "test",
          :endpoint     => "test",
          :user_agent   => "qwerty",
          :method       => "test",
        }
      end

      it "should ovverride module configuration" do
        api = CoordsafeApi::V1::Locator.new(@config)
        @keys.each do |key|
          api.send(key).should eq @config[key]
        end
      end

      it "should override module configuration after" do
        api = CoordsafeApi::V1::Locator.new

        @config.each do |key, value|
          api.send("#{key}=", value)
        end

        @keys.each do |key|
          api.send("#{key}").should eq @config[key]
        end
      end
    end
  end
end
