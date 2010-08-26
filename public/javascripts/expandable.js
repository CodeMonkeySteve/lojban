;(function($) {

$.fn.toggleExpand = function() {
  var content = $(this).find('.content').first(), wasVisible = content.is(':visible');
  content.slideToggle('slow');
  if ( wasVisible ) {
    this.collapse();
  } else {
    this.expand();
  }
};

$.fn.expand = function() {
  var header = this.find('.header').first(), icon = this.find('.ui-icon').first()
  this.addClass('expanded');
  this.removeClass('collapsed');
  header.removeClass('ui-corner-bottom');
  icon.removeClass('ui-icon-triangle-1-e');
  icon.addClass('ui-icon-triangle-1-s');
}

$.fn.collapse = function() {
  var header = this.find('.header').first(), icon = this.find('.ui-icon').first()
  this.removeClass('expanded');
  this.addClass('collapsed');
  header.addClass('ui-corner-bottom');
  icon.removeClass('ui-icon-triangle-1-s');
  icon.addClass('ui-icon-triangle-1-e');
}

$.fn.expandable = function() {
  return this.each( function() {
    var $this = $(this), header = $this.find('.header').first(), content = $this.find('.content').first(), expander = $this.find('.expander').first();

      $this.addClass('ui-widget ui-helper-reset');
     header.addClass('ui-widget-header  ui-corner-top    ui-state-default');
    content.addClass('ui-widget-content ui-corner-bottom');

    header.click( function() {  $this.toggleExpand();  } )
    if ( content.is(':visible') && !expander.is('.collapsed') ) {
      $this.expand();
    } else {
      $this.collapse();
      content.hide();
    }
  });
};

})(jQuery);

jQuery(document).ready( function(){  $('.ui-expandable').expandable();  });
