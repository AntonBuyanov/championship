class TopPlayers < ApplicationService
  def initialize(indicator, team = '')
    @indicator = indicator
    @team = team unless team.blank?
  end

  def call
    if @team
      players = @indicator.players.where(team_id: @team)
    else
      players = @indicator.players
    end

    players.group(:id).limit(5).order('COUNT("players"."id") DESC')
  end
end
