# frozen_string_literal: true

require 'rails_helper'

RSpec.describe HomeController, type: :controller do
  describe 'GET #index' do
    it 'renders the #index template' do
      get :index
      expect(response).to render_template('home/index')
    end

    it 'returns http success' do
      get :index
      expect(response).to have_http_status(:success)
    end
  end
end
