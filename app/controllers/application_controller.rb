class ApplicationController < ActionController::Base
#  include ::RedirectBack
  before_filter :authenticate_user!

  #protect_from_forgery
  layout 'application'

  before_filter :set_locale
  def set_locale
    I18n.locale = params[:locale]
  end

  def default_url_options( opts = {} )
    { :locale => I18n.locale }
  end
end
