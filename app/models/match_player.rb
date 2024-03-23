class MatchPlayer < ApplicationRecord
  belongs_to :match
  belongs_to :player
  belongs_to :team

  validates :match, :player, :team, presence: true
  validates :player, uniqueness: { scope: :match_id, message: "Игрок уже в составе матча" }
  validate :command_not_announced
  validate :player_not_enlisted

  private

  def command_not_announced
    errors.add(:base, :teams, message: "Команда не заявлена на матч") unless team == match.team_first || team == match.team_second
  end

  def player_not_enlisted
    errors.add(:player, "Игрок не состоит в команде") unless player.team == team
  end
end
