require 'spec_helper'

describe Proximity::RouteSet do
  let(:route_set) { mock_routes }

  it "works" do
    expect { route_set }.not_to raise_error
  end
  
end
