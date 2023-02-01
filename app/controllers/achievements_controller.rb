class AchievementsController < ApplicationController
  before_action :load_achievement, only: [:show]

  def index
    render json: Achievement.all
  end

  def show
    render json: @achievement
  end

  private

  def load_achievement
    @achievement = Achievement.find(params[:id])
  end
end
