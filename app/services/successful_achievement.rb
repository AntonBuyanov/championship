class SuccessfulAchievement < ApplicationService
  def initialize(player, match, indicator)
    @player = player
    @match = match
    @indicator = indicator
  end

  def call
    @player.achievements.create(match_id: @match, indicator_id: @indicator)
  end
end
