class MatchesController < ApplicationController
  before_action :load_match, only: [:show]

  def index
    render json: Match.all
  end

  def show
    render json: @match
  end

  private

  def load_match
    @match = Match.find(params[:id])
  end
end
