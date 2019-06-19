# frozen_string_literal: true

module LeagueStats
  def sort_by_teams
    @game_teams.group_by { |game| game['team_id'] }
  end

  def count_of_teams
    sort_by_teams.keys.length
  end

  def best_offense
    averages = sort_by_teams.transform_values do |value|
      value.inject(0) { |acc, game| acc + game['goals'].to_i } / value.length.to_f
    end
    best = @teams.find { |team| team['team_id'] == averages.key(averages.values.max) }
    best['teamName']
  end

  def worst_offense
    averages = sort_by_teams.transform_values do |value|
      value.inject(0) { |acc, game| acc + game['goals'].to_i } / value.length.to_f
    end
    worst = @teams.find { |team| team['team_id'] == averages.key(averages.values.min) }
    worst['teamName']
  end

  def best_defense
    # total_goals = @game_teams.group_by do |game|
    #                 game['team_id']
    #               end.transform_values do |value|
    #   value.inject(0) { |acc, game| acc + game['goals'].to_i }
    # end

    # best = @teams.find { |team| team['team_id'] == total_goals.key(total_goals.values.max) }
    # best['teamName']
  end

  def worst_defense; end

  def highest_scoring_visitor
    average_score = sort_by_teams.transform_values do |value|
      value.inject(0) do |acc, game|
        acc += game['goals'].to_i if game['HoA'] == 'away'
        acc
      end / value.length.to_f
    end
    best = @teams.find { |team| team['team_id'] == average_score.key(average_score.values.max) }
    best['teamName']
  end

  def highest_scoring_home_team
    average_score = sort_by_teams.transform_values do |value|
      value.inject(0) do |acc, game|
        acc += game['goals'].to_i if game['HoA'] == 'home'
        acc
      end / value.length.to_f
    end
    best = @teams.find { |team| team['team_id'] == average_score.key(average_score.values.max) }
    best['teamName']
  end

  def lowest_scoring_visitor
    average_score = sort_by_teams.transform_values do |value|
      value.inject(0) do |acc, game|
        acc += game['goals'].to_i if game['HoA'] == 'away'
        acc
      end / value.length.to_f
    end
    worst = @teams.find { |team| team['team_id'] == average_score.key(average_score.values.min) }
    worst['teamName']
   end

  def lowest_scoring_home_team
    average_score = sort_by_teams.transform_values do |value|
      value.inject(0) do |acc, game|
        acc += game['goals'].to_i if game['HoA'] == 'home'
        acc
      end / value.length.to_f
    end
    worst = @teams.find { |team| team['team_id'] == average_score.key(average_score.values.min) }
    worst['teamName']
   end

  def winningest_team
    percentage = sort_by_teams.transform_values do |value|
      wins = value.select { |v| v['won'] == 'TRUE' }
      wins.length.to_f / value.length
    end
    team = @teams.find { |team| team['team_id'] == percentage.key(percentage.values.max) }
    team['teamName']
  end

  def best_fans
    percentage = sort_by_teams.map do |team, games|
      home_wins = games.select { |game| game['HoA'] == 'home' && game['won'] == 'TRUE' }
      away_wins = games.select { |game| game['HoA'] == 'away' && game['won'] == 'TRUE' }

      [team, home_wins.length.to_f / games.length - away_wins.length.to_f / games.length]
    end.to_h

    team = @teams.find { |team| team['team_id'] == percentage.key(percentage.values.max) }
    team['teamName']
  end

  def worst_fans
    percentage = sort_by_teams.map do |team, games|
      home_wins = games.select { |game| game['HoA'] == 'home' && game['won'] == 'TRUE' }
      [team, home_wins.length.to_f / games.length < 0.5]
    end.to_h

    percentage.values.reject { |more_home| more_home }
  end
end
