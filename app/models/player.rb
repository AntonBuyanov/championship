class Player < ApplicationRecord
  belongs_to :team
  has_many :achievements
  has_many :match_players, dependent: :destroy
  has_many :matches, through: :match_players

  enum role: %i(attacker defender midfielder goalkeeper)

  validates :number, :team, presence: true
  validates_length_of :name,
                      minimum: 5, maximum: 50,
                      presence: true

  def last_five_matches
    matches.order(updated_at: :desc).limit(5)
  end
end
