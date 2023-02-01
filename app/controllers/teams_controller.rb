class TeamsController < ApplicationController
  before_action :load_team, only: [:show]

  def index
    render json: Team.all
  end

  def show
    render json: @team
  end

  private

  def load_team
    @team = Team.find(params[:id])
  end
end
