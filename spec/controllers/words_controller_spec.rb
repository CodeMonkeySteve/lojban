require 'spec_helper'

describe WordsController do
  it 'renders the index page' do
    get :index, :locale => 'en'
    response.should be_success
    response.should render_template('words/index')
  end

  it 'renders the search page' do
    get :search, :locale => 'en'
    response.should be_success
    response.should render_template('words/search')
  end

  it 'renders the show page' do
    word = Factory.create :word
    get :show, :id => word.id, :locale => 'en'
    response.should be_success
    response.should render_template('words/show')
  end
end
