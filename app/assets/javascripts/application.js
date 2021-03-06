// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require_tree .

$(document).ready(function(){
  $(".profile").hide();
  $(".user_name").mouseenter(function() {
    $(".profile").show();
  });
  $(".profile_info").mouseleave(function() {
    $('.profile').hide();
  });

  $("#games_by_season_season").change(function() {
    if ($("#games_by_season_season").val() != "") {
      $(this).parent().submit();
    };
  });

  $("#teams_name").change(function() {
    if ($("#teams_name").val() != "") {
      $(this).parent().submit();
    };
  });
});
