require 'em-synchrony/em-http'
$stdout.sync = true

module Jbovlaste
  def self.mirror
    puts 'Mirroring ...'
    doc = REXML::Document.new fetch( :path => '/export/xml.html' )
    langs = {}
    doc.elements.each('html/body//ul/li/a')  do |link|
      if link.attributes['href'] =~ /xml-export\.html\?lang=(.*)$/
        lang = $1
        next  if %w(test art-loglan).include?(lang)
        langs[lang] = link.text.gsub('&nbsp;', ' ')
        fetch :path => '/export/xml-export.html', :query => "lang=#{lang}"
      end
    end

    begin
      require 'langs'
    rescue LoadError
      lang_path = File.join( File.dirname(__FILE__), 'langs.rb' )
      File.open( lang_path, 'w' )  do |io|
        io.puts \
          '#encoding: UTF-8', 'module Jbovlaste', '  Langs = {',
            *langs.map { |code, name| "    '#{code}' => '#{name}',"  },
          '  }.freeze', 'end'
      end
      retry
    end
  end

  def self.import( lang )
    puts "Importing #{Langs[lang]} (#{lang}) ..."
    import = Importer.new lang
    doc = REXML::Document.new File.open( File.join( Rails.root, CacheDir, "xml-export.html?lang=#{lang}" ) )

    print '  definitions ... '
    count = 0
    doc.elements.each('dictionary/direction/valsi') { |v|  import.valsi(v) ; count += 1 }
    puts "done (#{count} words)"

    print '  translations ... '
    count = 0
    doc.elements.each('dictionary/direction/nlword') { |w|  import.nlword(w) ; count += 1 }
    puts "done (#{count} words)"
  end

  BaseUrl = URI::HTTP.build( :host => 'jbovlaste.lojban.org' ).freeze
  CacheDir = 'public/jbovlaste'.freeze  # relative to rails root

protected
  def self.fetch( opts )
    url = BaseUrl.dup.merge URI::Generic.build(opts)
    dest = File.join( Rails.root, CacheDir, File.basename( url.to_s ) )

    unless File.exists? dest
      puts "Fetching #{url} ..."
      http = EventMachine::HttpRequest.new(url).get(:timeout => 300)
      raise "Fetch failed: #{http.error}"  if http.error.present? || http.response.blank?
      File.open( dest, 'w' ) { |io|  io.print http.response.force_encoding('utf-8')  }
    end

    File.open dest
  end

  class Importer
    def initialize( lang )
      @lang = lang
    end

    def valsi( valsi )
      word = Word.find_or_initialize_by( :name => valsi.attributes['word'].downcase )
      parts = valsi.elements.to_a('rafsi').map(&:text)
      word.parts = parts

      lang = word.denotations.find_or_initialize_by( :lang => @lang )
      return unless lang.new_record?
      lang.definition = valsi.elements['definition'].text

      tags = []
      if %r{^\(?([0-9a-z -/]{5,43}):}i =~ lang.definition
        tags << $1.downcase
      end

      tags << valsi.attributes['type']
      el = valsi.elements['selmaho']
      tags << el.text  if el

      if el = valsi.elements['notes']
        notes = el.text.dup

        if @lang == 'en'
          related = []
          while notes.match( /(^|(;|\.)\s*)((see( also)?)|(cf\.?))[^.]*?(,?\s*\{(\S+)\},?)/i )
            related << $8.downcase
            notes.slice! Range.new( *$~.offset(7), true )
          end
          notes.sub!(/(^|(;|\.)\s*)((see( also)?)|(cf\.?))\s*:?\s*([.;]|$)/i, '\2')
          word.related = related.map { |w|  Word.find_or_create_by( :name => w ) }

          synonyms = []
          while notes.match( /(^|(;|\.)\s*)(syn\.)[^.]*?(,?\s*\{(\S+)\},?)/i )
            synonyms << $5.downcase
            notes.slice! Range.new( *$~.offset(4), true )
          end
          notes.sub!(/(^|(;|\.)\s*)(syn\.)\s*([.;]|$)/i, '\2')
          word.synonyms = synonyms.map { |w|  Word.find_or_create_by( :name => w ) }
        end

        lang.notes = el.text
      end

      lang.tags = tags
      word.denotations << lang
      word.save!
    end

    def nlword( nlword )
      word = Word.find_or_initialize_by( :name => nlword.attributes['valsi'].downcase )
      lang = word.denotations.find_or_initialize_by( :lang => @lang )

      translation = nlword.attributes['word']
      sense = nlword.attributes['sense']
      translation += " (#{sense})"  if sense
      lang.translations << translation
      word.save!
    end
  end
end
