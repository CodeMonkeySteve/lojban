module WordsHelper
  def refs_to_html( text )
    text.gsub! /\$(\w+)_\{?(\d+)\}?\$/, '<span class="ref \1\2">\1<sub>\2</sub></span>'
    text.gsub! /\{([^}]+)\}/  do |m|
      link_to $1, word_path(:id => $1)
    end
    text.html_safe
  end

  def first_letter_counts
    # TODO: move to map/reduce
    @first_letter_counts ||= Hash[ Word.only(:name).map(&:name).group_by { |n|  n[0] }.map { |l, n|  [ l, n.size ] }.sort ]
  end

  def first_letter_font_sizes( range )
    max = first_letter_counts.values.max
    Hash[ first_letter_counts.map { |l, c|  [l, range.begin + (c.to_f * (range.end - range.begin) / max)] } ]
  end

  def word_list( words )
    words.map do |word|
      opts = {}
      opts[:title] = word.local.translations.first  if word.local.try(:translations).present?
      link_to word.name, word_path(:id => word.name), opts
    end.join(', ').html_safe
  end
end
