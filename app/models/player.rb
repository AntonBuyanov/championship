class Player < ApplicationRecord
  belongs_to :team

  has_many :achievements

  def last_five_matches
    Match.where("team_first_id = :team_id OR team_second_id = :team_id", team_id: team_id)
         .order(updated_at: :desc)
         .limit(5)
  end
end
