class User
  include Mongoid::Document

  # Include default devise modules. Others available are:
  # :token_authenticatable, :lockable and :timeoutable
  devise :database_authenticatable, :registerable, :confirmable, :recoverable, :rememberable, :trackable, :validatable

  attr_accessor :password_confirmation

  field :identity_url
  validates_uniqueness_of :identity_url

  field :full_name
  validates_presence_of :full_name

protected
  def password_required?
    identity_url.blank? && (encrypted_password.blank? || password.present? || password_confirmation.present?)
  end
end