class Achievement < ApplicationRecord
  belongs_to :match
  belongs_to :player
  belongs_to :indicator

  validates :match, :player, :indicator, presence: true
end
