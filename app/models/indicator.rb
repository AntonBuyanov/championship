class Indicator < ApplicationRecord
  has_many :achievements, dependent: :destroy
  has_many :matches, through: :achievements
  has_many :players, through: :achievements
end
