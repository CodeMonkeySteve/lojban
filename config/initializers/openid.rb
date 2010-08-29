Warden::OpenID.configure do |config|
  config.required_fields = 'email'
  config.optional_fields = %w(fullname)

  config.user_finder do |response|
    user = User.where( :identity_url => response.identity_url ).first
    unless user
      fields = OpenID::SReg::Response.from_success_response(response)
      user = User.new :identity_url => response.identity_url, :email => fields['email'], :full_name => fields['fullname']
      user.skip_confirmation!
      user.save!
    end
    user
  end
end

module OpenidMongodbStore
  # load connection lazily
  def self.database
    @@database ||= Mongoid.database
  end
end
Lojban::Application.config.middleware.insert_after( ActionDispatch::Session::MongoidStore, Rack::OpenID, OpenidMongodbStore::Store.new )
