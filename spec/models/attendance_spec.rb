require 'spec_helper'

describe Attendance do
  let(:event) { create(:event, user: user) }
  let(:user) { create(:user) }
  let(:attendance) { create(:attendance, event: event, user: user) }
  
  describe 'アテンダンスが生成出来る' do
    subject { attendance }
    it { should be_instance_of Attendance }
  end

  describe 'relations' do
    it { should belong_to(:event) }
    it { should belong_to(:user) }
  end
end
