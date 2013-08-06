require 'spec_helper'

describe CoordsafeApi::Locator do
  context "on utilizing the API" do
    before(:each) do
      @api = CoordsafeApi::Locator.new({:company_name => "2", :secret => "test-1234qwer"})
    end

    it "should respond with the CoordsafeApi::Response object on #locate" do
      request = @api.locate
      request.class.should eq(CoordsafeApi::Response)
    end

    it "should respond with an Array of JSON on #locate" do
      request = @api.locate
      results = request.body
      results.class.should eq(Array)
      results.each do |r|
        r.class.should eq(Hash)
      end
    end

    it "should return true for success" do
      request = @api.locate
      request.success.should be_true
    end

    it "should respond with the CoordsafeApi::Response object on #locate_history with date_from" do
      request = @api.locate_history(18, DateTime.parse("2013-01-27 09:30"))
      request.class.should eq(CoordsafeApi::Response)
    end

    it "should respond with JSON on #locate_history with date_from" do
      request = @api.locate_history(18, DateTime.parse("2013-01-27 09:30"))
      results = request.body
      results.class.should eq(Hash)
    end

    it "should return true for success" do
      request = @api.locate_history(18, DateTime.parse("2013-01-27 09:30"))
      request.success.should be_true
    end

    it "should respond with the CoordsafeApi::Response object on #locate_history with date_from and date_to" do
      request = @api.locate_history(18, DateTime.parse("2013-01-27 09:00"), DateTime.parse("2013-01-27 10:00"))
      request.class.should eq(CoordsafeApi::Response)
    end

    it "should respond with JSON on #locate_history with date_from and date_to" do
      request = @api.locate_history(18, DateTime.parse("2013-01-27 09:00"), DateTime.parse("2013-01-27 10:00"))
      results = request.body
      results.class.should eq(Array)
      results.each do |r|
        r.class.should eq(Hash)
      end
    end

    it "should return true for success" do
      request = @api.locate_history(18, DateTime.parse("2013-01-27 09:00"), DateTime.parse("2013-01-27 10:00"))
      request.success.should be_true
    end


    it "should parameterize date_from on #paramemterize" do
      CoordsafeApi::Locator.parameterize(DateTime.parse("2013-07-06 9:30")).should eq("07-06-2013%2009:30")
    end

    it "should parameterize dates on #parameterize" do
      CoordsafeApi::Locator.parameterize(DateTime.parse("2013-07-06 9:30"), DateTime.parse("2013-07-08 5:00")).should eq("07-06-2013%2009:30,07-08-2013%2005:00")
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
            :secret                  => "qwerty",
            :company_name            => "qwerty",
            :format                  => "test",
            :locator_endpoint        => "test",
            :history_endpoint        => "test",
            :single_history_endpoint => "test",
            :user_agent              => "qwerty",
            :method                  => "test",
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
