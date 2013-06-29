require 'spec_helper'

describe AttendanceAuthorizer do
  let(:user) { create(:user) }
  let(:group) { create(:group) }
  let(:event) { create(:event, user: user, group: group) }
  let(:attendance) { Attendance.new(event: event) }

  describe 'instances' do
    describe 'index' do
      before do
        group.join(user, level)
      end
      context 'グループのオーナーである' do
        let(:level) { :owner }
        it { attendance.authorizer.readable_by?(user).should be_true }
      end

      context 'グループのオーナーではない' do
        let(:level) { :member }
        it { attendance.authorizer.readable_by?(user).should be_false }
      end
    end

    describe 'update' do
      before do
        group.join(user, level)
      end
      context 'グループのオーナーである' do
        let(:level) { :owner }
        it { attendance.authorizer.updatable_by?(user).should be_true }
      end

      context 'グループのオーナーではない' do
        let(:level) { :member }
        it { attendance.authorizer.updatable_by?(user).should be_false }
      end
    end

    describe 'create' do
      context '全体公開' do
        it { attendance.authorizer.creatable_by?(user).should be_true }
      end

      context '秘密' do
        before do
          group.update(privacy_scope: :private)
        end
        context 'グループのメンバーである' do
          before do
            group.join(user, :owner)
          end
          it { attendance.authorizer.creatable_by?(user).should be_true }
        end

        context 'グループのメンバーではない' do
          it { attendance.authorizer.creatable_by?(user).should be_false }
        end
      end
    end

    describe 'delete' do
      context '全体公開' do
        it { attendance.authorizer.deletable_by?(user).should be_true }
      end

      context '秘密' do
        before do
          group.update(privacy_scope: :private)
        end
        context 'グループのメンバーである' do
          before do
            group.join(user, :owner)
          end
          it { attendance.authorizer.deletable_by?(user).should be_true }
        end

        context 'グループのメンバーではない' do
          it { attendance.authorizer.deletable_by?(user).should be_false }
        end
      end
    end
  end
end
