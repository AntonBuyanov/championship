require 'rails_helper'

RSpec.describe PlayersController, type: :controller do
  let(:team) { create(:team) }
  let(:team2) { create(:team) }
  let(:player) { create(:player, team: team) }
  let(:player2) { create(:player, team: team2) }
  let(:match) { create(:match, team_first: team, team_second: team2) }
  let(:indicator) { create(:indicator) }

  describe 'GET #index' do
    let!(:players) { create_list(:player, 3, team_id: team.id) }

    before { get :index }

    it 'responds with status 200' do
      get :index

      expect(response.status).to eq(200)
    end

    it 'should return list of players' do
      expect(JSON.parse(response.body).size).to eq(3)
    end
  end

  describe 'GET #show' do
    before { get :show, params: { id: player.id }  }

    it 'expect return team id' do
      expect(JSON.parse(response.body)['id']).to eq(player.id)
    end
  end

  describe 'GET #check_achievement' do
    let!(:achievement) { create(:achievement, indicator: indicator, match: match, player: player) }
    let!(:match_player1) { create(:match_player, player: player, match: match, team: team) }
    let!(:match_player2) { create(:match_player, player: player2, match: match, team: team2) }

    it 'expect return true' do
      get :check_achievement, params: { id: player.id, indicator_id: indicator.id }

      expect(JSON.parse(response.body)).to eq(true)
    end

    it 'expect return false' do
      get :check_achievement, params: { id: player2.id, indicator_id: indicator.id }

      expect(JSON.parse(response.body)).to eq(false)
    end
  end

  describe 'GET #successful_achievement' do
    it 'create achievement' do
      get :successful_achievement, params: { id: player.id, match_id: match.id, indicator_id: indicator.id }

      expect(JSON.parse(response.body)['player_id']).to eq(player.id)
    end
  end
end
