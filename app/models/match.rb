class Match < ApplicationRecord
  belongs_to :team_first, class_name: 'Team'
  belongs_to :team_second, class_name: 'Team'

  has_many :achievements, dependent: :destroy
  has_many :match_players, dependent: :destroy

  validates :team_first, :team_second, presence: true
  validate :different_teams

  def composition_first_team
    match_players.where(team: team_first)
  end

  def composition_second_team
    match_players.where(team: team_second)
  end

  def declare_player(player, team)
    match_players.create(player: player, team: team)
  end

  private

  def different_teams
    errors.add(:base, :teams, message: "Команды должны быть разными") if team_first == team_second
  end
end
