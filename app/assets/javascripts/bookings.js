$(document).ready(function(){

    $(document).bind('ajaxError', 'form#new_booking', function(event, jqxhr, settings, exception){
  
      // note: jqxhr.responseJSON undefined, parsing responseText instead
      $(event.data).render_form_errors( $.parseJSON(jqxhr.responseText) );
      console.log("create.js.erb  GLOBAL" + event.data);
  
    });
  
  });
  
  (function($) {
  
    $.fn.modal_success = function(){
      // close modal
      this.modal('hide');
  
      // clear form input elements
      // todo/note: handle textarea, select, etc
      this.find('form input[type="text"]').val('');
  
      // clear error state
      this.clear_previous_errors();
    };
  
    $.fn.render_form_errors = function(errors){
  
      $form = this;
      this.clear_previous_errors();
      model = this.data('model');// doesn't work cannot fetch model from req
      console.log("GLOBAL eRRORS " + errors);
      // show error messages in input form-group help-block
      $.each(errors, function(field, messages){
        // $input = $('input[name="' + model + '[' + field + ']"]');
        $input = $('#booking_' + field );
        $input2 = $('.input.datetime.optional.booking_time');
        console.log("eRRORS inout " + $input);
        console.log("eRRORS field " + field);
        console.log("eRRORS msg " + messages);
        $input.closest('.form-group').addClass('has-error').find('.help-block').html( messages.join(' & ') );
        $input2.closest('.form-group').addClass('has-error').find('.help-block').html( messages.join(' & ') );
      });
  
    };
  
    $.fn.clear_previous_errors = function(){
      $('.form-group.has-error', this).each(function(){
        $('.help-block', $(this)).html('');
        $(this).removeClass('has-error');
      });
    }
  
  }(jQuery));