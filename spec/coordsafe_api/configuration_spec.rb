require 'coordsafe_api'

describe CoordsafeApi::Configuration do
  describe "when setting the configuration" do
    after do
      CoordsafeApi.reset
    end

    it "should set the configuration keys" do
      CoordsafeApi.configure do |config|
        config.secret = "qwerty"
        config.company_name = "EdeyaLabs"
      end

      CoordsafeApi.secret.should eq "qwerty"
      CoordsafeApi.company_name.should eq "EdeyaLabs"
    end
  end
end
