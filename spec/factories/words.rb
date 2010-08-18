Factory.define :word do |w|
  w.name 'klama'
  w.parts %w(kla)
  w.denotations([
    Denotation.new( :lang => 'en', :translations => %w(come), :tags => %w(gismu),
      :definition => %q($x_{1}$ comes/goes to destination $x_{2}$ from origin $x_{3}$ via route $x_{4}$ using means/vehicle $x_{5}$.),
      :notes => %q(Also travels, journeys, moves, leaves to ... from ...; $x_1$ is a traveller; ($x_4$ as a set includes points at least sufficient to constrain the route relevantly).  See also {cadzu}, {bajra}, {marce}, {vofli}, {litru}, {muvdu}, {cpare}, cmavo list {ka'a}, {pluta}, {bevri}, {farlu}, {limna}, {vitke}.)
    )
  ])

  #references_many :related, :class_name => 'Word', :stored_as => :array
  #references_many :synonyms, :class_name => 'Word', :stored_as => :array
end
