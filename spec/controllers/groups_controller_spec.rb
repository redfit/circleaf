require 'spec_helper'
describe GroupsController do
  let(:user) { create(:user) }
  let(:group) { create(:group) }
  before do
    GroupsController.any_instance.should_receive(:authorize_action_for)
    sign_in user
  end
  subject { response }

  describe 'show' do
    before do
      get :show, id: group.id
    end
    it { should be_success }
  end

  describe 'edit' do
    before do
      get :edit, id: group.id
    end
    it { should be_success }
  end

  describe 'update' do
    before do
      put :update, id: group.id, group: {content: 'hoge'}
    end
    it { should be_redirect }
  end

  describe 'destroy' do
    before do
      delete :destroy, id: group.id
    end
    it { should be_redirect }
  end
end
