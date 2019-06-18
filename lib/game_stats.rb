module GameStats
  def highest_total_score
    @games.map do |game|
      game["home_goals"].to_i + game["away_goals"].to_i
    end.max
  end

  def lowest_total_score
    @games.map do |game|
      game["home_goals"].to_i + game["away_goals"].to_i
    end.min
  end

  def biggest_blowout
    
  end

  def percentage_home_wins
    
  end

  def percentage_visitor_wins
    
  end

  def count_of_games_by_season
    
  end

  def average_goals_per_game
    
  end

  def average_goals_by_season
    
  end

end