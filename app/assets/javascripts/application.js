// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require jquery-ui
//= require bootstrap
//= require_tree .
//= require autocomplete-rails

$(function() {
/* Convenience for forms or links that return HTML from a remote ajax call.
The returned markup will be inserted into the element id specified.
*/
  $('form[data-update-target]').live('ajax:success', function(evt, data) {
    var target = $(this).data('update-target');
    $('#' + target).html(data);
  });
});

/* Form Validation */
$(document).ready(function () {
  $("#review_form").validate({
    rules: {
      rating: {
        required: true
      }
    },
    messages: {
      rating: {
        required: "The rating is required."
      },
    },
    errorPlacement: function (error, element) {
      if (element.is('input[type="text"]')) {
        error.insertAfter(element);
      } else if (element.is('input[type="radio"]')) {
        //used span instead of defaul lable because it's rendered as star
        $("#radio_error").html(error);
      } else {
        error.insertAfter(element);
      }
    }
  });
});

$(document).ready(function(){ 
  $("#content_1").charCount();
  $("#content_2").charCount();
  $("#content_3").charCount();
  $("#content_4").charCount();
});
