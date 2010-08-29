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

  def self.letter_counts
    # TODO: intelligent memoization
    @@letter_counts ||= begin
      res = self.collection.map_reduce( *LetterCountsJS ).find
      Hash[ *res.map { |d|  [ d['_id'], Integer(d['value']['count']) ] }.flatten ]
    end
  end

#protected
  LetterCountsJS = [
    "function() {
      emit( this.name.charAt(0), {count: 1} );
    }",
    "function( key, values ) {
      var total = {count: 0};
      values.forEach( function(val){
        total.count += val.count
      });
      return total;
    }"
  ].freeze
end
