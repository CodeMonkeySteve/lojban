module ApplicationHelper
  def nav_tab( text, options = {} )
    html_class = ['tab']
    if current_page?(options)
      html_class << 'current'
    else
      text = link_to text, options
    end
    content_tag :li, text, :class => html_class
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
end
