var sort = $("table").attr("class");
var categories = ["name","games","points","points_per_game","plays","plays_per_game",
"yards","yards_per_game","yards_per_play","rushes","rushing_yards","rushing_yards_per_game",
"yards_per_rush","completions","passes","completion_percentage","passing_yards","passing_yards_per_game",
"yards_per_pass","third_down_conversions","third_down_attempts","third_down_percentage",
"penalties","penaty_yards","penalty_yards_per_game","fumbles","fumbles_lost","interceptions","turnovers",
"turnovers_per_game"];
var column_id = 0
$("td").each(function() {
  $(this).addClass(categories[column_id]);
  column_id += 1;
  if (column_id == categories.length) {
    column_id = 0;
  };
  if (sort == $(this).attr("class")) {
    $(this).addClass("sorted");
  };
});
