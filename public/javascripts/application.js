jQuery(document).ready( function(){
//   jQuery('.tab').corner('bottom 5px');
//   jQuery('.tab.current').corner('5px');

  $('button, input:submit').button();
  $('select').selectmenu();

  $('input[autocomplete]').each(function(i){
    $(this).autocomplete({
      source: $(this).attr('autocomplete'),
      html: true
    });
  });
});

var redirect_to_lang = function( lang ) {
  var path = window.location.pathname.replace( /^\/[^/]+\//, '/' + lang + '/' );
  window.location.assign( window.location.protocol + "//" + window.location.host + path );
}