require 'spec_helper'
describe AttendancesController do
  let(:user) { create(:user) }
  let(:group) { create(:group, user: user) }
  let(:event) { create(:event, group: group, user: user) }
  before do
    AttendancesController.any_instance.should_receive(:authorize_action_for)
    sign_in user
  end
  subject { response }

  describe 'index' do
    before do
      get :index, event_id: event.id 
    end
    it { should be_success }
  end

  describe 'update' do
    before do
      event.join(user)
      attendance = event.attendance_for(user)
      put :update, id: attendance.id, attendance: {status: 'attend'}
    end
    it { should be_redirect }
  end
end
