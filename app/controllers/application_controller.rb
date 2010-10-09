class ApplicationController < ActionController::Base
#  include ::RedirectBack
  layout 'application'
  protect_from_forgery
  before_filter :authenticate_user!

  before_filter :set_locale
  def set_locale
    I18n.locale = params[:locale]
  end

  def default_url_options( opts = {} )
    { :locale => I18n.locale }
  end
end
