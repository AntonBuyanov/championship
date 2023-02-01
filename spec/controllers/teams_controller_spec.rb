require 'rails_helper'

RSpec.describe TeamsController, type: :controller do
  let(:team) { create(:team) }

  describe 'GET #index' do
    let!(:teams) { create_list(:team, 3) }

    before { get :index }

    it 'responds with status 200' do
      get :index

      expect(response.status).to eq(200)
    end

    it 'should return list of teams' do
      expect(JSON.parse(response.body).size).to eq(3)
    end
  end

  describe 'GET #show' do
    before { get :show, params: { id: team.id }  }

    it 'expect return team id' do
      expect(JSON.parse(response.body)['id']).to eq(team.id)
    end
  end
end
