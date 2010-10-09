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

  def self.letter_counts( lang = I18n.locale )
    counts = self.collection.map_reduce( *LetterCountsJS, :query => { :denotations => { :$exists => true } } )
    res = counts.find(:_id => lang.to_s).first
    if res && res['value']
      Hash[ *res['value'].map { |l, c|  [ l, Integer(c) ] }.sort.flatten ]
    else
      {}
    end
  end

protected
  LetterCountsJS = [
    "function() {
      word = this;
      this.denotations.forEach( function(deno){
        var doc = {};
        doc[word.name.charAt(0)] = 1;
        emit( deno.lang, doc );
      })
    }",
    "function( key, docs ) {
      var total = {};
      docs.forEach(function(doc) {
        for ( var key in doc ) {
          if ( !total[key] ) {  total[key] = 0;  }
          total[key] += doc[key];
        }
      });
      return total;
    }"
  ].freeze
end
