module ClassHelper

  def team_class(team)
    if user_signed_in? && (current_user.team_id == team.id)
      team_class = "favorite"
    else
      team_class = "team"
    end
    team_class
  end

end
