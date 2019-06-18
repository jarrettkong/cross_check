# frozen_string_literal: true

require 'csv'
require_relative './game_stats'

class StatTracker
  include GameStats

  attr_accessor :games, :teams, :game_teams

  def initialize(games, teams, game_teams)
    @games = games
    @teams = teams
    @game_teams = game_teams
  end

  def self.from_csv(files)
    data = files.map { |_, file| CSV.read(file, headers: true) }
    StatTracker.new(*data)
  end
end
