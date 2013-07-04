require 'spec_helper'

describe CoordsafeApi::Locator do
  context "on utilizing the API" do
    xit "should respond with JSON on #locate" do
      api = CoordsafeApi::Locator.new({:company_name => "Sypher Labs Pte. Ltd.", :key => "test-1234qwer"})
      response = api.locate("test")
      response.class.should eq("String")
    end
  end

  context "on configuration" do
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
        api = CoordsafeApi::Locator.new
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
          api = CoordsafeApi::Locator.new(@config)
          @keys.each do |key|
            api.send(key).should eq @config[key]
          end
        end

        it "should override module configuration after" do
          api = CoordsafeApi::Locator.new

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
end
