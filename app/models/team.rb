class Team < ApplicationRecord
  has_many :players, dependent: :destroy

  validates :name, :number, presence: true
end
