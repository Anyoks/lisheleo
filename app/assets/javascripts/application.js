// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require bootstrap-sprockets
//= require jquery_ujs
//= require rails-ujs
//= require turbolinks
//= require chart
//= require moment
//= require fullcalendar
//= require jquery-ui/widgets/draggable
//= require jquery-ui/widgets/droppable
//= require jquery-ui/widgets/datepicker
//= require app
//= require_tree .


// var initialize_calendar;
// var get_programs;



// get_programs =  $(function () {
//     $.ajax({
//         url: '/programs.json',                              
//         type: 'GET',
//         dataType: 'json',
//         complete: function (jqXHR, textStatus) {
//                 // callback
//         },
//         success: function (data, textStatus, jqXHR) {
//         //   alert(data);
//           // from here on you could also get the product id 
//           // or whatever you need
//           var x = 6;
//          $.each(data, function(k)  { 
             
//             //  console.log(data[k].name); // name of products
//              $(function(){
//                 console.log("adding div " + x + " " + data[k].name );
//                 $('#my-draggable').append("<div class=\"external-event " + x + " ui-draggable ui-draggable-handle\" style= \"background-color: rgb(114, 175, 210); border-color: rgb(114, 175, 210); color: rgb(255, 255, 255); position: relative; z-index: 10\">" + data[k].name +"</div");
//                 $('.external-event.' + x).data('event', { title: data[k].name, duration: '00:50', color: '#257e4a' });
//              });
             
//              x = x+1;
//             });

//             return true;
//         },
//         error: function (jqXHR, textStatus, errorThrown) {
//             // error callback
//             return false;
//         }
//     });
// });

function  GetPrograms(callback){
    $.ajax({
                url: '/programs.json',                              
                type: 'GET',
                dataType: 'json',
                complete: function (jqXHR, textStatus) {
                        // callback
                },
                success: function (data, textStatus, jqXHR) {
                //   alert(data);
                  // from here on you could also get the product id 
                  // or whatever you need
                  var x = 6;
                 $.each(data, function(k)  { 
                     
                    //  console.log(data[k].name); // name of products
                     $(function(){
                        console.log("adding div " + x + " " + data[k].name );
                        $('#my-draggable').append("<div class=\"external-event " + x + " ui-draggable ui-draggable-handle\" style= \"background-color: rgb(114, 175, 210); border-color: rgb(114, 175, 210); color: rgb(255, 255, 255); position: relative; z-index: 10\">" + data[k].name +"</div");
                        $('.external-event.' + x).data('event', { title: data[k].name, duration: '00:50', color: '#257e4a' });
                     });
                     
                     x = x+1;
                    });
        
                   callback(); // call the calendar funct
                   return;
                },
                error: function (jqXHR, textStatus, errorThrown) {
                    // error callback
                    return false;
                }
            });
}

function initCal(){
    $('.external-event').draggable(
        {
            revert: true,      // immediately snap back to original position
            revertDuration: 0,  //
        }
    );

    $('.external-event.1').data('event', { title: 'Personalized wellness', duration: '00:50', color: '#257e4a' });
    $('.external-event.2').data('event', { title: 'Therapeutic Massage', duration: '00:50', color: '#f39c12' });
    $('.external-event.3').data('event', { title: 'Keep fit', duration: '00:50', color: '#0073b7' });
    $('.external-event.4').data('event', { title: 'Cancer support', duration: '00:50', color: '#00c0ef' });


    $('#calendar').fullCalendar(

        {
            droppable: true,
            header: {
                left: 'prev,next, today',
                center: 'title',
                right: 'month,agendaWeek,agendaDay'
            },
            selectable: true,
            editable: true,
            defaultView: 'agendaWeek', // changing view to agenda view    
            minTime: '06:00:00',
            maxTime: '19:00:00',
            events: '/dashboard.json',
            textColor: 'white',
            weekends: false,
            // select: function(start, end){
            //     $.getScrip('/bookings/new',function(){

            //     });
            // },
            drop: function (date,jsEvent, ui, resourceId) {
                alert("Dropped on " + date.format());

                console.log("qqq" + date.format());
                duration = $(this).data('event').duration; // accessing the event object that has just been dropped.
                title = $(this).data('event').title;

                console.log("ttt" + duration);
                console.log("rrr" + title);
                var timeDuration = moment.duration(duration); // convert string into duration
                var end = date.clone().add(timeDuration); // on drop we only have date given to us add that to the start

                // get the time to auto pupulate start time field
                var hour       = date.format('HH');
                var mins       = date.format('mm');
                var sec        = date.format('ss');
                var year       = date.format('YYYY');
                var month      = date.format('MM');
                var day        = date.format('D');

                // get the time to auto pupulate end time field
                var end_hour   = end.format('HH');
                var end_mins   = end.format('mm');
                var end_sec    = end.format('ss');
                var end_year   = end.format('YYYY');
                var end_month  = end.format('MM');
                var end_day    = end.format('D');
        

                
                console.log('QQQQQQ' + ' ' + year + ' ' +  month + ' ' + day + ' ' + hour + ' ' + mins + ' ' + sec);

                console.log('EEEEE' + ' ' + end_year + ' ' +  end_month + ' ' + end_day + ' ' + end_hour + ' ' + end_mins + ' ' + end_sec);
                $.getScript('/bookings/new',function(){

                    // Populate the data fields based on where the event was dropped.
                    $('#booking_description').val(title);
                    $('#booking_time_1i').val( year); // YEAR
                    $('#booking_time_2i').val(month); // month
                    $('#booking_time_3i').val(day); // day
                    $('#booking_time_4i').val(hour); // hour
                    $('#booking_time_5i').val(mins); // minutes

                    //end time
                    $('#booking_end_time_1i').val(end_year); // YEAR
                    $('#booking_end_time_2i').val(end_month); // month
                    $('#booking_end_time_3i').val(end_day); // day
                    $('#booking_end_time_4i').val(end_hour); // hour
                    $('#booking_end_time_5i').val(end_mins); // minutes
                    
    
                });

                // var test = get_programs;

                console.log('GGGGGGGGGGGG' + test);
            },
            eventReceive: function(event){
                console.log("Event Drop call back");
                console.log(event);
            },
            eventDrop: function (event, delta, revertFunc) {
                console.log("Event Drop call back");
            }
        }
    );
}

// initialize_calendar = $(function () {

//     $('.external-event').draggable(
//         {
//             revert: true,      // immediately snap back to original position
//             revertDuration: 0,  //
//         }
//     );

//     $('.external-event.1').data('event', { title: 'Personalized wellness', duration: '00:50', color: '#257e4a' });
//     $('.external-event.2').data('event', { title: 'Therapeutic Massage', duration: '00:50', color: '#f39c12' });
//     $('.external-event.3').data('event', { title: 'Keep fit', duration: '00:50', color: '#0073b7' });
//     $('.external-event.4').data('event', { title: 'Cancer support', duration: '00:50', color: '#00c0ef' });


//     $('#calendar').fullCalendar(

//         {
//             droppable: true,
//             header: {
//                 left: 'prev,next, today',
//                 center: 'title',
//                 right: 'month,agendaWeek,agendaDay'
//             },
//             selectable: true,
//             editable: true,
//             defaultView: 'agendaWeek', // changing view to agenda view    
//             minTime: '06:00:00',
//             maxTime: '19:00:00',
//             events: '/dashboard.json',
//             textColor: 'white',
//             weekends: false,
//             // select: function(start, end){
//             //     $.getScrip('/bookings/new',function(){

//             //     });
//             // },
//             drop: function (date,jsEvent, ui, resourceId) {
//                 alert("Dropped on " + date.format());

//                 console.log("qqq" + date.format());
//                 duration = $(this).data('event').duration; // accessing the event object that has just been dropped.
//                 title = $(this).data('event').title;

//                 console.log("ttt" + duration);
//                 console.log("rrr" + title);
//                 var timeDuration = moment.duration(duration); // convert string into duration
//                 var end = date.clone().add(timeDuration); // on drop we only have date given to us add that to the start

//                 // get the time to auto pupulate start time field
//                 var hour       = date.format('HH');
//                 var mins       = date.format('mm');
//                 var sec        = date.format('ss');
//                 var year       = date.format('YYYY');
//                 var month      = date.format('MM');
//                 var day        = date.format('D');

//                 // get the time to auto pupulate end time field
//                 var end_hour   = end.format('HH');
//                 var end_mins   = end.format('mm');
//                 var end_sec    = end.format('ss');
//                 var end_year   = end.format('YYYY');
//                 var end_month  = end.format('MM');
//                 var end_day    = end.format('D');
        

                
//                 console.log('QQQQQQ' + ' ' + year + ' ' +  month + ' ' + day + ' ' + hour + ' ' + mins + ' ' + sec);

//                 console.log('EEEEE' + ' ' + end_year + ' ' +  end_month + ' ' + end_day + ' ' + end_hour + ' ' + end_mins + ' ' + end_sec);
//                 $.getScript('/bookings/new',function(){

//                     // Populate the data fields based on where the event was dropped.
//                     $('#booking_description').val(title);
//                     $('#booking_time_1i').val( year); // YEAR
//                     $('#booking_time_2i').val(month); // month
//                     $('#booking_time_3i').val(day); // day
//                     $('#booking_time_4i').val(hour); // hour
//                     $('#booking_time_5i').val(mins); // minutes

//                     //end time
//                     $('#booking_end_time_1i').val(end_year); // YEAR
//                     $('#booking_end_time_2i').val(end_month); // month
//                     $('#booking_end_time_3i').val(end_day); // day
//                     $('#booking_end_time_4i').val(end_hour); // hour
//                     $('#booking_end_time_5i').val(end_mins); // minutes
                    
    
//                 });

//                 var test = get_programs;

//                 console.log('GGGGGGGGGGGG' + test);
//             },
//             eventReceive: function(event){
//                 console.log("Event Drop call back");
//                 console.log(event);
//             },
//             eventDrop: function (event, delta, revertFunc) {
//                 console.log("Event Drop call back");
//             }
//         }
//     );




// })
// $(document).on('turbolinks:load',get_programs );
// $(document).on('turbolinks:load',initialize_calendar );
$(document).on('turbolinks:load',GetPrograms(initCal) );