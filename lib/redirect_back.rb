module RedirectBack
  def redirect_back_url
    @session_return_to
  end

protected
  def redirect_to( *args )
    if args.first == :back
      opts = args.second || {}
      super( @session_return_to || opts[:default] || :back )
    else
      preserve_redirect_back_url
      super
    end
  end

  def load_redirect_back_url
    @session_return_to = session[:return_to]  unless request.xhr?
puts "loaded redirect_back_url: #{@session_return_to}"
  end

  def save_redirect_back_url
    session[:return_to] = request.fullpath  unless request.xhr?
puts "saving redirect_back_url: #{session[:return_to]}"
  end

  def preserve_redirect_back_url
    session[:return_to] = @session_return_to
  end

  # inclusion hook to create actionpack filters
  def self.included( base )
    base.send :before_filter, :load_redirect_back_url
    base.send :before_filter, :save_redirect_back_url_on_request
  end

  def save_redirect_back_url_on_request
    save_redirect_back_url  if request.get? && !%w{new edit}.include?(self.action_name)
  end
end