require 'jbovlaste'

EM.synchrony do
  Jbovlaste.mirror
  Jbovlaste::Langs.keys.each { |l|  Jbovlaste.import(l) }
  EM.stop
end
