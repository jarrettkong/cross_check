# frozen_string_literal: true

module GameStats
  def highest_total_score
    @games.map do |game|
      game['home_goals'].to_i + game['away_goals'].to_i
    end.max
  end

  def lowest_total_score
    @games.map do |game|
      game['home_goals'].to_i + game['away_goals'].to_i
    end.min
  end

  def biggest_blowout
    @games.map do |game|
      (game['home_goals'].to_i + game['away_goals'].to_i).abs
    end.max
  end

  def percentage_home_wins
    @games.select do |game|
      game['outcome'].include?('home win')
    end.length.to_f / @games.length
  end

  def percentage_visitor_wins
    @games.select do |game|
      game['outcome'].include?('away win')
    end.length.to_f / @games.length
  end

  def count_of_games_by_season
    @games.inject({}) do |acc, game|
      acc[game['season']] = 0 unless acc[game['season']]
      acc[game['season']] += 1
      acc
    end
  end

  def average_goals_per_game; end

  def average_goals_by_season; end
end
