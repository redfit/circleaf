class User < ActiveRecord::Base
  include Authority::UserAbilities
  include Markdownable
  markdownable :content
  devise :rememberable, :trackable, :omniauthable
  has_many :connections
  has_many :memberships
  has_many :groups, through: :memberships
  has_many :attendances
  has_many :events, through: :attendances
  has_many :posts
  has_one :setting, class_name: 'UserSetting'

  validates :email, email_format: {allow_nil: true}
  validates :unconfirmed_email, email_format: {allow_nil: true}

  after_create :create_setting

  class << self
    def authentication(auth_hash, current_user = nil)
      begin
        params = {
          provider: auth_hash['provider'],
          uid: auth_hash['uid'],
          name: auth_hash['info']['name'],
          image: auth_hash['info']['image'],
          access_token: auth_hash['credentials']['token'],
          secret_token: auth_hash['credentials']['secret'],
        }
      rescue => e
        return nil
      end
      
      connection = Connection.where(provider: params[:provider], uid: params[:uid]).first_or_initialize
      user = current_user ? current_user : connection.user
      user = User.create(name: params[:name], image: params[:image]) unless user

      params[:user] = user
      connection.update_attributes(params)
      
      return user
    end
  end

  def me?(user)
    return self.id == user.id
  end

  def update_email(email)
    self.unconfirmed_email = email
    self.confirm_limit_at = Time.current + 3.hour
    self.hash_to_confirm_email = confirm_key
    if self.save
      UserMailer.email_confirmation(self).deliver
    else
      return false
    end
  end

  def confirm_email(hash)
    if hash == self.hash_to_confirm_email && Time.current <= self.confirm_limit_at
      self.email = self.unconfirmed_email
      self.unconfirmed_email = nil
      self.confirm_limit_at = nil
      self.hash_to_confirm_email = nil
      self.save!
    end
  end

  private
  def create_setting
    self.setting = UserSetting.new
  end

  def confirm_key
    Digest::SHA1.hexdigest("#{self.id}#{Time.current.to_i}")
  end
end
