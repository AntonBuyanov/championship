class Indicator < ApplicationRecord
  has_many :achievements, dependent: :destroy
  has_many :matches, through: :achievements
  has_many :players, through: :achievements

  validates_length_of :name,
                      minimum: 5, maximum: 50,
                      presence: true
end
