require 'spec_helper'

describe Proximity::Router do

  let(:route_set) { mock_routes }
  let(:router)    { route_set.router }

  describe "parameters" do
    let(:match) { router.match 'PATH_INFO' => '/example/accounts/157/members/8932' }

    it "will properly parse path parameters from the input" do
      expect(match.matches).to eq(account_id: '157', member_id: '8932')
    end

    it "will properly bind path parameters to the output" do
      expect(match.target).to eq('http://example.dev/api/accounts-members/157-8932')
    end

    describe "that do not match" do
      let(:match) { router.match 'PATH_INFO' => '/lucy/in/the/sky/with/diamonds' }
      subject { match }
      it { should be_nil }

      describe "but have the same prefix" do
        let(:match) { router.match 'PATH_INFO' => '/example/accounts/157/panthers' }
        it { should be_nil }
      end
    end
  end

end
