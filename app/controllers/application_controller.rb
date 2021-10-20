class ApplicationController < ActionController::Base
  # after sign in
  def after_sign_in_path_for(resource)
    unless session[:origin].blank?
      session[:origin]
    else
      root_path
    end
  end
end
