class Team < ApplicationRecord
  has_many :players, dependent: :destroy

  validates_length_of :name,
                      minimum: 5, maximum: 50,
                      presence: true

  scope :percentage_players, -> (percent) { total_count = players.count; (percent / 100.0 * total_count).round }

  def matches
    Match.where("team_first_id = :team_id OR team_second_id = :team_id", team_id: id)
  end

  def percentage_players(percent)
    total_count = players.count
    num_players = (percent / 100.0 * total_count).round

    players.limit(num_players)
  end
end
