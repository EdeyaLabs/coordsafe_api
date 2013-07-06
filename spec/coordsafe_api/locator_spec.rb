require 'spec_helper'

describe CoordsafeApi::Locator do
  context "on utilizing the API" do
    before(:each) do
      @api = CoordsafeApi::Locator.new({:company_name => "Sypher Labs Pte. Ltd.", :key => "test-1234qwer"})
      stub_request(:get, "http://www.coordsafe.com.sg/CoordSafePortalApp/locators/lc/company/Sypher%20Labs%20Pte.%20Ltd.?key=")
        #.with(
        #:body => [ {"location":null,"imeiCode":"353301057336682","gpsLocation":{"time":0,"accuracy":0.0,"altitude":0.0,"bearing":0.0,
        #  "distance":0.0,"hasAccuracy":false,"hasAltitude":false,"hasBearing":false,"hasSpeed":false,"initialBearing":0.0,"latitude":1.5296516666666666,
        #  "longitude":103.77401,"speed":0.0},"deviceStatus":{"isGpsOn":false,"imei":"","isGsmOn":false,"networkAvailability":0,"ip":"","batteryLeft":0},
        #  "create":false,"assignedTo":"Sypher Labs Pte. Ltd.","id":35,"type":"CS","status":null,"madeBy":null,"madeDate":1423065600000,"model":"BBT-01",
        #  "label":"PDN399","lastLocationUpdate":1373096366341,"ownerId":"CS","lastStatusUpdate":1369535434914} ])
      stub_request(:get, "http://www.coordsafe.com.sg/CoordSafePortalApp/locators/lc/location/18/01-27-2013%2009:30?key=")
      stub_request(:get, "http://www.coordsafe.com.sg/CoordSafePortalApp/locators/lc/history/18/01-27-2013%2009:00,01-27-2013%2010:00?key=")
    end

    it "should respond with 200 (OK) on #locate" do
      request = @api.locate
      request.response.class.should eq(Net::HTTPOK)
    end

    it "should respond with 200 (OK) on #locate_history with date_from" do
      request = @api.locate_history(18, DateTime.parse("2013-01-27 09:30"))
      request.response.class.should eq(Net::HTTPOK)
    end

    it "should respond with 200 (OK) on #locate_history with date_from and date_to" do
      request = @api.locate_history(18, DateTime.parse("2013-01-27 09:00"), DateTime.parse("2013-01-27 10:00"))
      request.response.class.should eq(Net::HTTPOK)
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
