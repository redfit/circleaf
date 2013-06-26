class User < ActiveRecord::Base
  include Markdownable
  markdownable :content

  devise :rememberable, :trackable, :omniauthable
  has_many :connections
  has_many :memberships
  has_many :groups, through: :memberships
  has_many :attendances
  has_many :events, through: :attendances
  has_many :posts

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
end
