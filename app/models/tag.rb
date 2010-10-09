class Tag
  include Mongoid::Document

  def self.counts
    infos = Content.collection.map_reduce( MAP_FUNC, REDUCE_FUNC, :sort => [:id, Mongo::ASCENDING] ).find.to_a
    Hash[ *infos.map { |h|  [ h['_id'], h['value'] ] }.flatten ]
  end

  MAP_FUNC = 'function() {
    for (i in this.tags) {
      var info = {count: 1, related: {}}
      for each (tag in this.tags) {
        if ( tag != this.tags[i] ) {
          info.related[tag] = 1;
        }
      }
      emit( this.tags[i], info );
    }
  }'.freeze
  REDUCE_FUNC = 'function(key, vals) {
    var sum = {count: 0, related: {}};
    vals.forEach(function(val) {
      sum.count += val.count;
      for (var tag in val.related) {
        sum.related[tag] = (sum.related[tag] || 0) + val.related[tag];
      };
    });
    return sum;
  }'.freeze
end
