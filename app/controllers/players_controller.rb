class PlayersController < ApplicationController
  before_action :load_player, only: [:show, :check_achievement, :successful_achievement]

  def index
    render json: Player.all
  end

  def show
    render json: @player
  end

  def check_achievement
    render json: CheckAchievement.call(@player, params[:indicator_id])
  end

  def successful_achievement
    render json: SuccessfulAchievement.call(@player, params[:match_id], params[:indicator_id])
  end

  private

  def load_player
    @player = Player.find(params[:id])
  end
end
