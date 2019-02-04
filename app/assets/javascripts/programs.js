
// $(document).on('turbolinks:load', picker );
// $(function () {
//     console.log('COLOR PICKER MAIN');
//     $('.input-group-addon').colorpicker();
// });

// $('.input-group-addon').onChange('colorpickerChange', function (event) {
    //     console.log('COLOR PICKER EVENT ');
    //     // $('#program_color').css('background-color', event.color.toString());
    // });
    // jQuery(function(){

    //     $('.input-group-addon').click('colorpickerChange', function (event) {
    //         console.log('COLOR PICKER EVENT ');
    //         $('#program_color').css('background-color', event.color.toString());
    //     });
      
    // });
    // $('#program_color').on('colorpickerChange', function (event) {
    //     console.log('COLOR PICKER EVENT ');
    //     $('.input-group-addon').css('background-color', event.color.toString());
    // });
    $('#program_color').colorpicker().on('colorpickerChange', function (e) {
        $('.input-group-addon').css('background-color', event.color.toString()); 
        // initialize the input on colorpicker creation
    //    io.val(e.color.string());
    //
    //    io.on('change keyup', function () {
    //        e.colorpicker.setValue(io.val());
    //    });
        console.log('COLOR PICKER www');
    })
