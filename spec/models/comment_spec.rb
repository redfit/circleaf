require 'spec_helper'

describe Comment do
  let(:user) { create(:user) }
  let(:group) { create(:group) }
  let(:event) { create(:event, group: group, user: user) }
  let(:comment) { create(:comment, commentable: event, user: user) }

  describe 'コメントが生成出来る' do
    subject { comment }
    it { should be_instance_of Comment }
  end

  describe 'relations' do
    it { should belong_to(:commentable) }
    it { should belong_to(:user) }
  end
end
