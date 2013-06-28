require 'spec_helper'
describe EventsController do
  let(:user) { create(:user) }
  let(:owner_user) { create(:user) }
  let(:group) { create(:group) }
  let(:event) { create(:event, user: owner_user, group: group) }

  before do
    EventsController.any_instance.should_receive(:authorize_action_for)
    sign_in user
  end
  subject { response }

  describe 'index' do
    before do
      get :index, group_id: group.id
    end
    it { should be_success }
  end


  describe 'show' do
    before do
      get :show, id: event.id
    end
    it { should be_success }
  end

  describe 'edit' do
    before do
      get :edit, id: event.id
    end
    it { should be_success }
  end

  describe 'update' do
    before do
      put :update, id: event.id, event: {content: 'hoge'}
    end
    it { should be_redirect }
  end

  describe 'destroy' do
    before do
      delete :destroy, id: event.id
    end
    it { should be_redirect }
  end
end
