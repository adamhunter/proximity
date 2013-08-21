require 'spec_helper'

describe Proximity::RouteSet do
  let(:router)    { mock_routes }
  let(:route)     { router.routes.first }
  let(:proxy)     { route.proxy }
  let(:route_set) { proxy.send :route_set }

  it "will set the source prefix on the route set" do
    expect(route_set.source).to eq('/example/')
  end

  it "will set the target prefix on the route set" do
    expect(route_set.target).to eq('http://example.local/api/')
  end

  it "will create a route with the given prefix for its source" do
    expect(proxy.source).to eq('/example/active')
  end

  it "will map the given prefix to the target prefix" do
    expect(proxy.target).to eq('http://example.local/api/are/you/active')
  end


  describe "protocol" do
    it "will be added to the target prefix if missing" do
      expect(route_set.target).to eq('http://example.local/api/')
    end

    it "will not add a protocol if provided in the target prefix" do
      target    = 'ftp://example.local/api/' 
      route_set = described_class.new(router)
      route_set.source = 'example'
      route_set.target = target
      expect(route_set.target).to eq(target)
    end
  end

  describe "tld" do
    before(:each) { Proximity.stub(:env).and_return(environment) }
    after(:each)  { ENV['PROXIMITY_ENV'] = 'test' }

    context 'develepment' do
      let(:environment) { 'development' }

      it "will convert .com into .local" do
        expect(route_set.target).to eq('http://example.local/api/')
      end
    end

    context 'test' do
      let(:environment) { 'test' }

      it "will convert .com into .local" do
        expect(route_set.target).to eq('http://example.local/api/')
      end
    end

    context 'production' do
      let(:environment) { 'production' }

      it "will not convert .com into .local" do
        expect(route_set.target).to eq('http://example.com/api/')
      end
    end
  end

  describe "formats" do
    context "when given json and csv" do
      let(:json) { router.routes[2].proxy }
      let(:csv)  { router.routes[3].proxy }

      it "creates a route with a format of json" do
        expect(json.format).to eq('json')
      end

      it "creates a route with a format of csv" do
        expect(csv.format).to eq('csv')
      end
    end
  end
end
