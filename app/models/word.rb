class Word
  include Mongoid::Document
  extend ActiveSupport::Memoizable

  field :name, :type => String, :required => true, :unique => true
  field :parts, :type => Array  # of String
  embeds_many :denotations
  references_many :related, :class_name => 'Word', :stored_as => :array
  references_many :synonyms, :class_name => 'Word', :stored_as => :array

  index :name, :unique => true
  index 'denotations.lang'
  index 'denotations.translations'

  def local
    denotations.where( :lang => I18n.locale.to_s ).first
  end
  memoize :local
end
