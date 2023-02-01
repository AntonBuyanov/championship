class CheckAchievement < ApplicationService
  def initialize(player, indicator)
    @player = player
    @indicator = indicator
  end

  def call
    Achievement.where(player: @player, match: @player.last_five_matches, indicator: @indicator).exists?
  end
end
