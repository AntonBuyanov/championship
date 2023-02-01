class IndicatorsController < ApplicationController
  before_action :load_indicator, only: [:top_players]

  def index
    render json: Indicator.all
  end

  def top_players
    render json: TopPlayers.call(@indicator, params[:team_id])
  end

  private

  def load_indicator
    @indicator = Indicator.find(params[:id])
  end
end
