class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  scope :random, -> { order(Arel.sql('RANDOM()')).first }
end
