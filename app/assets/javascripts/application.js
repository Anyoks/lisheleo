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
//= require app
//= require_tree .


var initialize_calendar;

initialize_calendar = $(function () {

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
            drop: function (date,jsEvent, ui, resourceId) {
                alert("Dropped on " + date.format());

                console.log("qqq" + date.format());
                duration = $(this).data('event').duration; // accessing the event object that has just been dropped.
                title = $(this).data('event').title;

                console.log("ttt" + duration);
                console.log("rrr" + title);
                var timeDuration = moment.duration(duration); // convert string into duration
                
                var end = date.clone().add(timeDuration); // on drop we only have date given to us add that to the start
                console.log('end is ' + end.format());
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




})

$(document).on('turbolinks:load', initialize_calendar);

// $(function () {

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
//             defaultView: 'agendaWeek', // changing view to agenda view    
//             minTime: '06:00:00',
//             maxTime: '19:00:00',
//             events: '/dashboard.json',
//             textColor: 'white',
//             weekends: false,
//             drop: function (date,jsEvent, ui, resourceId) {
//                 alert("Dropped on " + date.format());

//                 console.log("qqq" + date.format());
//                 duration = $(this).data('event').duration; // accessing the event object that has just been dropped.
//                 title = $(this).data('event').title;

//                 console.log("ttt" + duration);
//                 console.log("rrr" + title);
//                 var timeDuration = moment.duration(duration); // convert string into duration
                
//                 var end = date.clone().add(timeDuration); // on drop we only have date given to us add that to the start
//                 console.log('end is ' + end.format());
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



