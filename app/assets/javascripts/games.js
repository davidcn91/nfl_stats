$(document).ready(function() {
  if ($('.season_games').length != 1) {
    $('.season_games:not(:first)').hide();
  }

  $('.season_header').css('cursor', 'pointer');
  $('.week').css('cursor', 'pointer');

  $('.week').click(function() {
    $(this).next().toggle();
  });

  $('.season_header').click(function() {
    $(this).next().toggle();
  });
});
