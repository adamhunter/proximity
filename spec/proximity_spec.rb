require 'spec_helper'

describe Proximity do

  let(:proxy) { SpecProxy.new {} }
  before(:each) { proxy.stub(:perform_request).and_return([200, {}, ['']]) }

  it 'should have a version number' do
    Proximity::VERSION.should_not be_nil
  end

  describe "routing" do
    let(:env) { 
      {
        'SCRIPT_NAME' => __FILE__,
        'PATH_INFO' => '/example/accounts/15',
        'HTTP_HOST' => 'foobar.com',
      }
    }

    let!(:response) { proxy.call(env) }

    describe "script name" do
      it "is set to blank" do
        expect(env['SCRIPT_NAME']).to eq('')
      end
    end

    describe "http host" do
      it "is set based off the incoming route" do
        expect(env['HTTP_HOST']).to eq('example.dev')
      end
    end

    describe "path name" do
      it "is mapped based off the incoming route" do
        expect(env['PATH_INFO']).to eq('/api/accounts/15')
      end
    end
  end
end
