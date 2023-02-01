class Achievement < ApplicationRecord
  belongs_to :match
  belongs_to :player
  belongs_to :indicator
end
