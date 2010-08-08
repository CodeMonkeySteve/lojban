class ApplicationController < ActionController::Base
#  include ::RedirectBack
  before_filter :authenticate_user!

  #protect_from_forgery
  layout 'application'
end
