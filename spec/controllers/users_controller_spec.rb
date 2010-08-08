require 'spec_helper'

describe UsersController do
  describe 'with a logged-in user' do
    before do
      @user = Factory.create :user
      sign_in @user
    end

    it 'renders the dashboard' do
      get :dashboard
      response.should be_success
      response.should render_template('users/dashboard')
    end
  end
end
