require 'rails_helper'

RSpec.describe IndicatorsController, type: :controller do
  let(:team) { create(:team) }
  let(:team2) { create(:team) }
  let(:indicator) { create(:indicator) }
  let(:player) { create(:player, team: team) }
  let(:player2) { create(:player, team: team) }
  let(:player3) { create(:player, team: team) }
  let(:player4) { create(:player, team: team) }
  let(:player5) { create(:player, team: team2) }
  let!(:match) { create(:match, team_first: team, team_second: team2) }
  let!(:match2) { create(:match, team_first: team, team_second: team2) }
  let!(:match3) { create(:match, team_first: team, team_second: team2) }
  let!(:achievement) { create(:achievement, indicator: indicator, match: match, player: player) }
  let!(:achievement2) { create(:achievement, indicator: indicator, match: match, player: player2) }
  let!(:achievement3) { create(:achievement, indicator: indicator, match: match, player: player3) }
  let!(:achievement4) { create(:achievement, indicator: indicator, match: match, player: player4) }
  let!(:achievement5) { create(:achievement, indicator: indicator, match: match2, player: player5) }

  describe 'GET #top_players' do
    it 'return top players team' do
      get :top_players, params: { id: indicator.id, team_id: team.id }

      expect(JSON.parse(response.body).size).to eq(4)
    end

    it 'return top players championship' do
      get :top_players, params: { id: indicator.id}

      expect(JSON.parse(response.body).size).to eq(5)
    end
  end
end
