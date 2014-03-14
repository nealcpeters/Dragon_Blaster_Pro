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
//= require jquery.turbolinks
//= require jquery_ujs
//= require turbolinks
//= require_tree .

// * we go to the creation page
// * it prompts us for the map title and description
// * when that's submitted, it goes to the server and creates a new map
// * when the map info comes back, we save the map id to the window

// * then we click on a div square to bring up a room creation form
// on click:
//   * the div changes to pending color
//   * a room creation form pops up
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
        window.userId = $('#map_creator_id').val();
        $.ajax({
          type: 'post',
          url: url,
          data: data,
          success: function(serverResponse) {
            console.log(serverResponse);
            window.mapId = serverResponse.map_id;
            $('#dialog-form').dialog("close");
          }
        })
      },
      Cancel: function() {
        window.location.href = "/users/" + window.userId;
      }
    },
  });

  $('#finish-map').on('click', function() {
    $('.grid-cell').removeClass('clickable');
    $(document).on("click", '.grid-cell[id]', function(event){
      // TODO: send room id to db as a starting location
      // unbind click
      // display confirmation message "Room has been created" and 'Starting location is set'
      // Add link for 'Back' and 'Play'
      console.log('I am bound on all the elements with an id');
    });
  });

$(document).on("click", ".clickable", function(event){
  var that = event.target;
  $('.grid-cell').filter(function(index){
    return $(this).css('background-color') == "rgb(0, 0, 255)";
  }).css('background-color', 'white');
  currentSquare = that;
  $(that).css("background", "blue");
  $("#room-form-container").empty();
  $("#room-form-container").append("<form id='room-form' action='/users/" + window.userId + "/maps/" + window.mapId + "/rooms' method='POST'><input type='text' placeholder='Room Name' name='title'><textarea form='room-form' name='description' placeholder='Room Description'></textarea><input id='north_id' type='hidden' name='north_id'><input id='south_id' type='hidden' name='south_id'><input id='east_id' type='hidden' name='east_id'><input id='west_id' type='hidden' name='west_id'><input type='hidden' name='map_id' value=" + window.mapId + "><input type='submit' value='Add Room'></form>");
})

function getNorthId(currentSquare){
  if(! $(currentSquare).hasClass("row-1")){
    var index = $(currentSquare).index();
    var northRoom = $('.grid-cell')[index - 5];
    return $(northRoom).attr("id");
  }
};

function getSouthId (currentLocationIndex) {
  if(! $(currentSquare).hasClass("row-5") ){
    var index = $(currentSquare).index();
    var southRoom = $('.grid-cell')[index + 5];
    return $(southRoom).attr("id");
  }
}

var getWestId = function(currentLocationIndex) {
  if(! $(currentSquare).hasClass("col-1")){
    var index = $(currentSquare).index();
    var westRoom = $('.grid-cell')[index - 1];
    return $(westRoom).attr("id");
  }
}

var getEastId = function(currentLocationIndex) {
  if(! $(currentSquare).hasClass("col-5")){
    var index = $(currentSquare).index();
    var eastRoom = $('.grid-cell')[index + 1];
    return $(eastRoom).attr("id");
  }
}

  $(document).on("submit", "#room-form", function(){
    event.preventDefault();
    if(getNorthId(currentSquare)) {
      $("#north_id").val(getNorthId(currentSquare))
    }
    if(getSouthId(currentSquare)) {
      $("#south_id").val(getSouthId(currentSquare))
    }
    if(getEastId(currentSquare)) {
      $("#east_id").val(getEastId(currentSquare))
    }
    if(getWestId(currentSquare)) {
      $("#west_id").val(getWestId(currentSquare))
    }
    console.log($("#room-form").html());
    var url = $('#room-form').attr('action');
    var data = $('#room-form').serialize();
    $.ajax({
      url: url,
      type: "POST",
      beforeSend: function(xhr) {xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))},
      data: data,
      success: function(response){
        $(currentSquare).css("background-color", "green");
        $(currentSquare).text(response.room_name)
        $(currentSquare).removeClass('clickable');
        $(currentSquare).attr('id', response.room_id);
        $("#room-form-container").empty();
      }
    });
  });
});

