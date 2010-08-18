require 'spec_helper'

describe UsersController do
  describe 'with a logged-in user' do
    before do
      @user = Factory.create :user
      sign_in @user
    end
  end
end
