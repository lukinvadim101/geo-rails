# frozen_string_literal: true

require 'rails_helper'

describe LocationsController do
  describe 'GET index' do
    it 'renders :index template' do
      get :index
      expect(json['error']).to include(' need to sign in')
    end
  end
end
