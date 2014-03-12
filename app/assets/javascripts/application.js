// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require_tree .



// we go to the creation page
// it prompts us for the map title and description
// when that's submitted, it goes to the server and creates a new map
// when the map info comes back, we fill in a hidden map_id field on the forms for rooms


// then we click on a div square to bring up a room creation form
// on click:
//   the div changes to pending color
//   a room creation form pops up
//   the javascript checks the four divs around the div you clicked on
//     for each div, if that div has an id, the javascript fills in the hidden room-creation form field corresponding
//       to that room (north_id, south_id, east_id, or west_id) with that div's id
//   we submit the form, and it goes to the server
//   the server makes a new room with the information we gave it
//   then, it finds the north/south/east/west rooms (if any) by the ids we gave and changes their south/north/west/east
//     ids to the id of the room we just created
//   then we return to the browser, change the color of the div to the "completed" color, and add an id to the div
//     that is the same as its corresponding room's id (aka the room we just made)
//   we hide the form and maybe do a confirmation msg?



//   def change_east_rooms
//     west.east_id = room.id
//   end

$(function(){
  $("#dialog-form").dialog({
      autoOpen: true,
      height: 350,
      width: 250,
      dialogClass: 'no-close',
      modal: true,
      buttons: {
        "Submit": function() {
          var data = $('#new_map').serialize();
          var url = $('#new_map').attr('action');
          console.log(url);
          $.post(url, data, function(serverResponse) {
            window.map_id = serverResponse.map_id;
            $('#dialog-form').dialog("close");
          });
        },
        Cancel: function() {
          var userId = $('#map_creator_id').val();
          console.log(userId);
          window.location.href = "/user/" + userId;
        }
      },
    });
})


