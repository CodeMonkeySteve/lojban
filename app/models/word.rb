class Word
  include Mongoid::Document

  field :name, :type => String, :required => true
  field :parts, :type => Array  # of String
  embeds_many :denotations
  references_many :related, :class_name => 'Word', :stored_as => :array
  references_many :synonyms, :class_name => 'Word', :stored_as => :array
end
