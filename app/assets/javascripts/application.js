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


var sort = $("table").attr("class");
var categories = [["Team","name"],["G","games"],["Points","points"],["Pts/Gm","points_per_game"],
["Plays","plays"],["Plays/Gm","plays_per_game"],["Yards","yards"],["Yds/Gm","yards_per_game"],["Yds/Play","yards_per_play"],
["Rush","rushes"],["RuYds","rushing_yards"],["RuYds/Gm","rushing_yards_per_game"],["Yds/Rush","yards_per_rush"],
["Comp","completions"],["Pass","passes"],["Comp Pct","completion_percentage"],["PaYds","passing_yards"],["PaYds/Gm","passing_yards_per_game"],["Yds/Pass","yards_per_pass"],
["3rd Conv","third_down_conversions"],["3rd Att","third_down_attempts"],["3rd Pct","third_down_percentage"],
["Pen","penalties"],["Pen Yards","penaty_yards"],["Pen Yds/G","penalty_yards_per_game"],["Fum","fumbles"],
["Fum Lost","fumbles_lost"],["INT","interceptions"],["TO","turnovers"],["TO/G","turnovers_per_game"]];
var column_id = 0
$("td").each(function() {
  $(this).addClass(categories[column_id][1]);
  column_id += 1;
  if (column_id == categories.length) {
    column_id = 0;
  };
  if (sort == $(this).attr("class")) {
    $(this).addClass("sorted");
  };
});
