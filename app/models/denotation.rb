class Denotation
  include Mongoid::Document
  embedded_in :word, :inverse_of => :denotations

  field :lang, :type => String, :required => true
  field :definition, :type => String, :required => true
  field :translations, :type => Array, :default => []  # of String
  field :tags, :type => Array, :default => []  #  of String
  field :notes, :type => String
end
