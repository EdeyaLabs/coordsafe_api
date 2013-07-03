require 'spec_helper'

describe CoordsafeApi::V1::Locator do
  describe "configuration" do
    it "should return an api key" do
      CoordsafeApi.secret.should be_nil
    end

    it "should return a company name" do
      CoordsafeApi.company_name.should be_nil
    end
  end
end


describe CoordsafeApi::V2::Locator do
  xit "tests for Api Version 2" do
  end
end
