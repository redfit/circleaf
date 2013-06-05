class AuthenticationsController < Devise::OmniauthCallbacksController
  Connection::PROVIDERS.each do|provider|
    define_method provider.to_s do
      @user = User.authentication(env['omniauth.auth'], current_user)
      sign_in(@user)
      if @user.persisted?
        flash[:notice] = I18n.t('devise.omniauth_callbacks.success', kind: provider)
        sign_in_and_redirect @user, event: :authentication
      else
        flash[:notice] = I18n.t('devise.omniauth_callbacks.failure', kind: provider, reason: 'User create error')
        redirect_to root_path
      end
    end
  end

  def failure
    head(:ok)
  end
end
