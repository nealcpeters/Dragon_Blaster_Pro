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

$(function(){
  $("#dialog-form").dialog({
    autoOpen: true,
    modal: true,
    width: 250,
    dialogClass: 'no-close',
    buttons: {
      "Submit": function() {
        var data = $('#new_map').serialize();
        url = $('#new_map').attr('action');
        window.userId = $('#map_creator_id').val();
        $.ajax({
          type: 'post',
          url: url,
          data: data,
          success: function(serverResponse) {
            console.log(serverResponse);
            window.mapId = serverResponse.map_id;
            $('#dialog-form').dialog("close");
            $("#message").text("Okay, Cartographer! Time to give your map some rooms.  Click on a square to make a room at that location on your map.")
          }
        })
      },
      Cancel: function() {
        window.location.href = "/";
      }
    },
  });

  $('#finish-map').on('click', function() {
    $('.grid-cell').removeClass('clickable');
    $('#message').text("Wow, such map!  Click on the square you'd like your player to start in, and you'll be good to go.")
    $('.grid-cell').filter(function(index){
      return $(this).css('background-color') == "rgb(67, 119, 161)";
    }).css('background-color', 'none');
    $("#finish-map").hide();
    $("#room-form-container").empty();
    $(document).on("click", '.grid-cell[id]', function(event){
      var data = {"starting_room_id": $(this).attr('id')};
      $.ajax({
        beforeSend: function(xhr) {xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))},
        url: url + '/' + window.mapId,
        data: data,
        type: "PATCH",
        success: function(serverResponse){
          console.log(serverResponse);
          $('#message').text('Map has been created.  Starting point for your map has been set!');
          $(document).unbind();
          $("#back-or-play").show();
        }
      });
    });
  });

$(document).on("click", ".clickable", function(event){
  var that = event.target;
  $('.grid-cell').filter(function(index){
    return $(this).css('background-color') == "rgb(67, 119, 161)";
  }).css('background-color', 'transparent');
  currentSquare = that;
  $(that).css("background", "#4377A1");
  $("#room-form-container").empty();
  $("#room-form-container").append("<form id='room-form' action='/users/" + window.userId + "/maps/" + window.mapId + "/rooms' method='POST'><input type='text' placeholder='Room Name' name='title'><br><textarea form='room-form' name='description' placeholder='Room Description'></textarea><input id='north_id' type='hidden' name='north_id'><input id='south_id' type='hidden' name='south_id'><input id='east_id' type='hidden' name='east_id'><input id='west_id' type='hidden' name='west_id'><input type='hidden' name='map_id' value=" + window.mapId + "><br><input type='submit' value='Add Room'></form>");
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
    var data = $('#room-form').serialize();
    $.ajax({
      url:  $('#room-form').attr('action'),
      type: "POST",
      beforeSend: function(xhr) {xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))},
      data: data,
      success: function(response){
        $(currentSquare).css("background-color", "#67A143");
        $(currentSquare).text(response.room_name)
        $(currentSquare).removeClass('clickable');
        $(currentSquare).attr('id', response.room_id);
        $("#finish-map").show();
        $("#room-form-container").empty();
      }
    });
  });
});

