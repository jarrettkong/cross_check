# frozen_string_literal: true

module TeamStats
  def get_team(id)
    @teams.find { |team| team['team_id'] == id }
  end

  def team_info(id)
    get_team(id).map do |key, value|
      [key.gsub(/::/, '/')
          .gsub(/([A-Z]+)([A-Z][a-z])/, '\1_\2')
          .gsub(/([a-z\d])([A-Z])/, '\1_\2')
          .tr('-', '_')
          .downcase, value]
    end .to_h
  end

  def best_season(id)
    percentages = @games.group_by do |game|
      game['season']
    end.transform_values do |value|
      value.select do |game|
        game['home_team_id'] == id || game['away_team_id'] == id
      end
    end.transform_values do |value|
      value.inject([]) do |acc, game|
        if game['home_team_id'] == id && game['outcome'].include?('home')
          acc << game
        elsif game['away_team_id'] == id && game['outcome'].include?('away')
          acc << game
        end
      end.length / value.length.to_f
    end
    percentages.key(percentages.values.max)
  end

  def worst_season(id)
    percentages = @games.group_by do |game|
      game['season']
    end.transform_values do |value|
      value.select do |game|
        game['home_team_id'] == id || game['away_team_id'] == id
      end
    end.transform_values do |value|
      value.inject([]) do |acc, game|
        if game['home_team_id'] == id && game['outcome'].include?('home')
          acc << game
        elsif game['away_team_id'] == id && game['outcome'].include?('away')
          acc << game
        end
      end.length / value.length.to_f
    end
    percentages.key(percentages.values.min)
  end

  def average_win_percentage(id)
    
  end
end
