$(document).ready(function(){
   
});

(function initCal() {
    $id = $(this)[0].document.URL.split('/')[4] ;
    $('.external-event').draggable(
        {
            revert: true,      // immediately snap back to original position
            revertDuration: 0,  //
        }
    );

    // $('.external-event.1').data('event', { title: 'Personalized wellness', duration: '00:50', color: '#257e4a' });
    // $('.external-event.2').data('event', { title: 'Therapeutic Massage', duration: '00:50', color: '#f39c12' });
    // $('.external-event.3').data('event', { title: 'Keep fit', duration: '00:50', color: '#0073b7' });
    // $('.external-event.4').data('event', { title: 'Cancer support', duration: '00:50', color: '#00c0ef' });
    

    $('#user_calendar').fullCalendar(
        
        // id = (this).document.baseURI.split('/')[4] ;
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
            events: '/clients/'+ $id + '.json' ,
            textColor: 'white',
            displayEventEnd: true,
            displayEventTime: true,
            weekends: false,
            eventAfterRender: function (event, $el, view) {
                // var formattedTime = $.fullCalendar.formatDates(event.start, event.end, "HH:mm { - HH:mm}");
                eventsdate = moment(event.start).format('hh:mm a');
                eventedate = moment(event.end).format('hh:mm a');
                console.log("EMD DAREAASSDFSDFSD " + eventedate);
                // formattedTime = eventsdate + eventedate;
                // If FullCalendar has removed the title div, then add the title to the time div like FullCalendar would do
                $el.find(".fc-time").text(eventsdate + " - " + eventedate);
                // if($el.find(".fc-event-title").length === 0) {
                //     $el.find(".fc-time").text(eventsdate + " - " + eventedate + " "+ event.title);
                // }
                // else {
                //     $el.find(".fc-time").text(formattedTime);
                // }
            },
            drop: function (date, jsEvent, ui, resourceId) {
                alert("Dropped on " + date.format());

                console.log("qqq" + date.format());
                duration = $(this).data('event').duration; // accessing the event object that has just been dropped.
                title = $(this).data('event').title;

                console.log("ttt" + duration);
                console.log("rrr" + title);
                var timeDuration = moment.duration(duration); // convert string into duration
                var end = date.clone().add(timeDuration); // on drop we only have date given to us add that to the start

                // get the time to auto pupulate start time field
                var hour = date.format('HH');
                var mins = date.format('mm');
                var sec = date.format('ss');
                var year = date.format('YYYY');
                var month = date.format('M')
                var day = date.format('D');

                // get the time to auto pupulate end time field
                var end_hour = end.format('HH');
                var end_mins = end.format('mm');
                var end_sec = end.format('ss');
                var end_year = end.format('YYYY');
                var end_month = end.format('M');
                var end_day = end.format('D');



                console.log('QQQQQQ' + ' ' + year + ' ' + month + ' ' + day + ' ' + hour + ' ' + mins + ' ' + sec);


                console.log('EEEEE' + ' ' + end_year + ' ' + end_month + ' ' + end_day + ' ' + end_hour + ' ' + end_mins + ' ' + end_sec);

                console.log('aaaaaaaa' + ' ' + year + ' ' + month.toString().length + ' ' + day + ' ' + hour + ' ' + mins + ' ' + sec);



                $.getScript('/bookings/new', function () {

                    $("div.input.string.required.booking_client option").filter(function () {
                        // $k = $(this).html();
                        $l = $(this);
                        // console.log(" CLINET ID" + $l.val());
                        // console.log(" CLINET NAME" + $l.html());
                        return $l.val() == $id;
                    }).prop('selected', true)

                    $("div.input.string.required.booking_program option").filter(function () {
                        var k = $(this).html();
                        console.log(" QAQAQAQAQ" + k);
                        return $(this).html() == title;
                    }).prop('selected', true)

                    // Populate the data fields based on where the event was dropped    .
                    $('#booking_description').val(title);
                    $('#booking_time_1i').val(year); // YEAR
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

                // console.log('GGGGGGGGGGGG' + test);
            },
            eventReceive: function (event) {
                console.log("Event Drop call back");
                console.log(event);
            },
            eventDrop: function (event, delta, revertFunc) {
                console.log("Event Drop call back");
            }
        }
    );
}(jQuery));

