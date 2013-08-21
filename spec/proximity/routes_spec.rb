require 'spec_helper'

describe Proximity::Routes do

  let(:routes) { described_class.new }
  let(:router) { double('Router', source: 'foo', target: 'bar') }

  it "adds the proxy to the route" do
    proxy = routes.add_proxy(router, '/source', 'http://example.com/target', nil)
    route = routes.first
    expect(route.proxy).to eq proxy
  end

end
