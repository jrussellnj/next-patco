class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :set_as_private

  def set_as_private
    expires_now
  end
end
