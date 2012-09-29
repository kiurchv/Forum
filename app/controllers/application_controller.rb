class ApplicationController < ActionController::Base
  protect_from_forgery

  helper :all
  helper_method :is_current?

  def is_current?(user)
    user == current_user
  end
end
