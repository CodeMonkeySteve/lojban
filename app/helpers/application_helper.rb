module ApplicationHelper
  def nav_button( text, url_or_options, html_options = {} )
    if html_classes = html_options[:class]
      html_classes = html_classes.split(' ')  if html_classes.kind_of?(String)
    else
      html_classes = []
    end
    html_classes << 'nav_button'
    if scoped_current_page?( url_or_options, :controller, :action )
      html_classes << 'ui-state-active'
    else
      #html_classes << 'ui-state-default'
      text = link_to text, url_or_options
    end
    content_tag :span, text, html_options.merge(:class => html_classes)
  end

  def scoped_current_page?( url_or_options, *params )
    url = url_or_options.kind_of?(String) ? url_or_options : url_for(url_or_options)
    url = CGI.unescapeHTML(url)
    params = [:controller, :action]  if params.empty?
    begin
      Rails.application.routes.recognize_path(url_or_options).values_at(*params) == controller.request.symbolized_path_parameters.values_at(*params)
    rescue ActionController::RoutingError
      false
    end
  end

  def display_notices
    str = ''
    error  = flash[:alert]   #|| flash[:failure]
    notice = flash[:notice]  #|| flash[:success]

    if error.present?
      content = content_tag( 'span', error.to_s, :id => 'error_display_message' )
      str << content_tag( 'div', content, :class => 'error', :id => 'error_display' )
    end
    if notice.present?
      content = content_tag( 'span', notice.to_s, :id => 'notice_display_message' )
      str << content_tag( 'div', content, :class => 'notice', :id => 'notice_display' )
    end
    str.html_safe
  end

  def error_message_options( model )
    model = model.name.titleize  unless model.kind_of?(String)
    { :header_tag => 'h3', :message => nil, :header_message => "#{model} could not be saved, please fix these errors:", :class => 'error'  }
  end

  def link_to_unless_current( text, options = {}, html_options = {} )
    super( text, options, html_options ) {  content_tag( :span, text, html_options )  }
  end

  def options_for_language_select
    require 'langs'
    options_for_select Jbovlaste::Langs.map { |code, lang|  [ lang, code ] }, I18n.locale.to_s
  end
end
