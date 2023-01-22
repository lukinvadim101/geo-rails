# frozen_string_literal: true

require 'rails_helper'

describe LocationsController do
  describe 'GET index' do
    it 'renders :index template' do
      get :index
      expect(response.body).to include('redirected')
    end
  end
end
