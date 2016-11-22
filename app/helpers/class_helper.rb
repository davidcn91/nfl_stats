module ClassHelper

  def team_class(team)
    if user_signed_in? && (current_user.team_id == team.id)
      team_class = "favorite"
    else
      team_class = "team"
    end
    team_class
  end

  def stat_column_class(category, sort)
    if category == sort
      stat_column_class = "sorted"
    else
      stat_column_class = "not_sorted"
    end
    stat_column_class
  end

end
