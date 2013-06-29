require 'spec_helper'
describe MembershipsController do
  let(:user) { create(:user) }
  let(:group) { create(:group) }
  before do
    MembershipsController.any_instance.should_receive(:authorize_action_for)
    sign_in user
  end
  subject { response }

  describe 'index' do
    before do
      get :index, group_id: group.id
    end
    it { should be_success }
  end

  describe 'update' do
    before do
      group.join(user)
      membership = group.membership_for(user)
      put :update, id: membership.id, membership: {level: 'owner'}
    end
    it { should be_redirect }
  end
end
