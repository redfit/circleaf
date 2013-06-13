# coding: utf-8
require 'spec_helper'

describe Event do
  let(:user) { create(:user) }
  let(:group) { create(:group) }
  let(:event) { create(:event, group: group, user: user) }

  describe 'イベントを作成できる' do
    subject { event }
    it { should be_instance_of Event }
  end

  describe 'relations' do
    it { should belong_to(:user) }
    it { should belong_to(:group) }
    it { should have_many(:users).through(:attendances) }
    it { should have_many(:attend_users).through(:attend_attendances) }
    it { should have_many(:pending_users).through(:pending_attendances) }
    it { should have_many(:cancel_users).through(:cancel_attendances) }
  end

  describe 'イベント参加・キャンセル' do
    let(:users) { [] }
    subject { event.attendance_for(user) }
    before do
      attendances_count.times do
        users << create(:user)
        event.join(users.last)
      end
      event.join(user)
    end

    describe '参加' do
      context '参加人数に余裕がある' do
        let(:capacity_max) { 10 }
        let(:attendances_count) { 9 }
        it { subject.status.should eq 'attend' }
      end

      context '参加人数に余裕がない' do
        let(:capacity_max) { 10 }
        let(:attendances_count) { 10 }
        it { subject.status.should eq 'pending' }
      end
    end

    describe 'キャンセル' do
      let!(:first_pending_attendance) { event.pending_attendances.first }
      let!(:user) { users.first }
      before do
        event.leave(user)
      end

      context '参加人数に余裕がある' do
        let(:capacity_max) { 10 }
        let(:attendances_count) { 9 }
        it { subject.status.should eq 'cancel' }
        it { event.attend_attendances.should have(attendances_count - 1).items }
      end

      context '参加人数に余裕がない' do
        let(:capacity_max) { 10 }
        let(:attendances_count) { 15 }
        it { subject.status.should eq 'cancel' }
        it { first_pending_attendance.reload.status.should eq 'attend' }
        it { event.attend_attendances.should have(capacity_max).items }

        describe '最参加' do
          before do
            event.join(user)
          end
          let!(:last_pending_attendance) { event.pending_attendances.last }
          it '最後のキャンセル待ちに入ること' do
            last_pending_attendance.reload.should eq event.attendance_for(user)
          end
        end
      end
    end
  end
end
