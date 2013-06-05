include Warden::Test::Helpers
module FeatureMacros
  def self.included(base)
    base.extend ClassMethods
    base.after do
      Warden.test_reset!
    end
  end

  module ClassMethods
  end

  def sign_in(user)
    Warden.test_mode!
    user.confirm! if user.respond_to?(:confirm!)
    scope = user.class.to_s.downcase.to_sym
    login_as(user, scope: scope, run_callbacks: false)
  end

  def sign_out(user = nil)
    if user
      scope = user.class.to_s.downcase.to_sym
      logout(scope)
    else
      logout
    end
  end

  def reload
    visit page.current_path if page.current_path
  end
end
