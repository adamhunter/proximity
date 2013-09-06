require 'spec_helper'

describe Proximity::Proxy do
  let(:router)    { mock_routes }
  let(:route)     { router.routes[0].proxy }
  let(:same)      { router.routes[1].proxy }
  let(:format)    { router.routes[2].proxy }
  let(:blank)     { router.routes[6].proxy }

  it "prefixes the source with the route set source and a slash" do
    expect(route.source).to eq('/example/active')
  end

  it "does not add a slash to the route set source if source is blank" do
    expect(blank.source). to eq('/example')
  end

  it "prefixes the target with the route set target" do
    expect(route.target).to eq('http://example.local/api/are/you/active')
  end

  it "uses the source as the target if the target is Same" do
    expect(same.target).to eq('http://example.local/api/count')
  end

  describe "formats" do
    it "will add the format precceeded by a dot to the source" do
      expect(format.source).to eq('/example/accounts.json')
    end

    it "will add the format precceeded by a dot to the target" do
      expect(format.target).to eq('http://example.local/api/accounts.json')
    end
  end

end

