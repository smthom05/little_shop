class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :current_user
  helper_method :current_admin?
  helper_method :current_merchant?
  helper_method :current_registered?
  # helper_method :current_visitor?

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def current_admin?
    current_user && current_user.admin?
  end

  def current_merchant?
    current_user && current_user.merchant?
  end

  def current_registered?
    current_user && current_user.registered?
  end

  def require_admin
    render file: "/public/404" unless current_admin?
  end

  def require_merchant
    render file: "/public/404" unless current_merchant?
  end

  def require_current_user
    unless current_user && current_user.registered?
      render file: "/public/404", status: :not_found
    end
  end

  #
  # def current_visitor?
  #   current_user && current_user.visitor?
  # end
end
