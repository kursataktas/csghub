module SessionsHelper
  def log_in user
    session[:login_identity] = user.login_identity
  end

  def current_user
    @current_user ||= User.find_by_login_identity(session[:login_identity].presence)
  end

  def logged_in?
    current_user.present?
  end

  def logged_in_other_system?
    cookies[:idToken].present?
  end

  def user_roles
    current_user.roles.join(',')
  end

  def logout
    session[:login_identity] = nil
    cookies.delete :oidcUuid, domain: current_cookie_domain
    cookies.delete :idToken, domain: current_cookie_domain
    cookies.delete :userinfos, domain: current_cookie_domain
  end

  def login_url
    oidc_configs = SystemConfig.first&.oidc_configs || Rails.application.credentials.oidc_config.send(Rails.env)
    oidc_configs["login_url"]
  end
end
