require "spec_helper"

describe NotificationMailer do
  let(:user) { create(:user) }
  let(:group) { create(:group) }
  let(:event) { create(:event, group: group, user: user) }
  let(:attendance) { create(:attendance, event: event, user: user) }
  let(:comment) { create(:comment, commentable: event, user: user) }

  describe '#attend_status' do
    let(:mail) { NotificationMailer.attend_status(user, attendance) }
    it { mail.to.should eq [user.email] }
    it { mail.subject.should match I18n.t('mailer.notification.attend_status.subject', event_name: event.name) }
    it { mail.body.should match Regexp.new event_path(event) }
  end

  describe '#event_comment' do
    let(:mail) { NotificationMailer.event_comment(user, comment) }
    it { mail.to.should eq [user.email] }
    it { mail.subject.should match I18n.t('mailer.notification.event_comment.subject', event_name: event.name) }
    it { mail.body.should match Regexp.new event_path(event) }
  end

  describe '#event_attendance' do
    let(:mail) { NotificationMailer.event_attendance(user, attendance) }
    it { mail.to.should eq [user.email] }
    it { mail.subject.should match I18n.t('mailer.notification.event_attendance.subject', event_name: event.name) }
    it { mail.body.should match Regexp.new event_path(event) }
  end

  describe '#group_event' do
    let(:mail) { NotificationMailer.group_event(user, event) }
    it { mail.to.should eq [user.email] }
    it { mail.subject.should match I18n.t('mailer.notification.group_event.subject', group_name: event.group.name) }
    it { mail.body.should match Regexp.new event_path(event) }
  end
end
