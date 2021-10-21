class ApplicationController < ActionController::Base
  # after sign in
  def after_sign_in_path_for(resource)
    unless session[:origin].blank?
      redirect_path = session[:origin]
      redirect_path = "#{redirect_path}?quantity=#{session[:quantity]}" unless session[:quantity].blank?
      redirect_path
    else
      root_path
    end
  end
  # sign_in_and_redirect
end
