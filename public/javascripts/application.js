jQuery(document).ready( function(){
//   jQuery('.tab').corner('bottom 5px');
//   jQuery('.tab.current').corner('5px');

  $('button, input:submit').button();

  $('input[autocomplete]').each(function(i){
    $(this).autocomplete({
      source: $(this).attr('autocomplete'),
      html: true
    });
  });
});
