require 'jbovlaste'

desc 'Download lojban wordlists from jbovlaste (lojban.org)'
task 'lojban:mirror'  do
  Jbovlaste.mirror
  puts "Mirrored languages: ", Jbovlaste::Langs.map { |code, name|  "  * #{name} (#{code})" }
end

=begin
desc 'Download lojban word frequencies from lojban.org'
task 'lojban:freqs'  do
  url = 'http://lojban.org/publications/wordlists/frequencies.txt'
  dest = File.join RAILS_ROOT, 'public/data', File.basename(url)

  puts "Downloading word frequencies"
  Curl::Easy.download url, dest  do |curl|
    curl.verbose = true
  end
end
=end