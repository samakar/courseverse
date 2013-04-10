/*
 *   Character Count Plugin - jQuery plugin
 *   Dynamic character count for text areas and input fields
 *    written by Alen Grakalic
 *    http://cssglobe.com/
 *
 *
 * Updated to work with Twitter Bootstrap 2.0 styles by Shawn Crigger <@svizion>
 * http://blog.s-vizion.com
 * Mar-13-2011
 *
 *   Copyright (c) 2009 Alen Grakalic (http://cssglobe.com)
 *   Dual licensed under the MIT (MIT-LICENSE.txt)
 *   and GPL (GPL-LICENSE.txt) licenses.
 *
 *   Built for jQuery library
 *   http://jquery.com
 *
 *
 */

(function($) {

  $.fn.charCount = function(options){

      // default configuration properties
      var defaults = {
          allowed: 0,
          warning: 25,
          css: 'help-inline desc',
          counterElement: 'span',
          cssWarning: '',
          cssExceeded: 'alert-error',
          counterText: 'Characters left: '
      };

      var options = $.extend(defaults, options);

      function calculate(obj){
          var count = $(obj).val().length;
          if(options.allowed==0){
          	options.allowed = $(obj).attr('maxlength');
          }
          var available = options.allowed - count;
          if(available <= options.warning && available >= 0){
              $(obj).next().addClass(options.cssWarning);
          } else {
              $(obj).next().removeClass(options.cssWarning);
          }
          if(available < 0){
              $(obj).next().addClass(options.cssExceeded);
          } else {
              $(obj).next().removeClass(options.cssExceeded);
          }
          $(obj).next().html(options.counterText + available);
      };

      this.each(function() {
          $(this).after('<'+ options.counterElement +' class="' + options.css + '">'+ options.counterText +'</'+ options.counterElement +'>');
          calculate(this);
          $(this).next().hide();
          $(this).keyup(function(){
          	calculate(this);
          	$(this).height(20);
          	$(this).height(this.scrollHeight+20);
          });
          $(this).change(function(){calculate(this)});
          $(this).blur( function(){$(this).next().hide()} );
          $(this).focus( function(){$(this).next().show()} );
      });

  };

})(jQuery);