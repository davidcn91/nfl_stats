module TeamRanker

  def rank(teams)
    teams
    # teams.sort_by {|t| [t.win_percentage(@season, spread),t.record(@season, spread)[0],(t.record(@season, spread)[1]*-1)]}.reverse
  end

end
