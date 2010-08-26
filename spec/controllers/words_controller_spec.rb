require 'spec_helper'

describe WordsController do
  before do
    @word = Factory.create :word
  end
  it 'renders the index page' do
    get :index, :locale => 'en'
    response.should be_success
    response.should render_template('words/index')
pending 'have_selector'
    response.should have_selector( '.word .name', :content => @word.name )
  end

  it 'renders the show page' do
    get :show, :id => @word.id, :locale => 'en'
    response.should be_success
    response.should render_template('words/_word')
pending 'have_selector'
    response.should have_selector( '.word', :content => @word.name )
  end

  it 'renders the search page' do
    get :search, :locale => 'en'
    response.should be_success
    response.should render_template('words/search')
pending 'have_selector'
    response.should have_selector( 'li.word', :content => @word.name )
  end

  it 'auto-completes a word (w/ AJAX)' do
    xhr :get, :autocomplete, :term => @word.name[0...-1], :locale => 'en'
    response.should be_success
    ActiveSupport::JSON.decode(response.body).should == [{
      'id' => @word.id.to_s, 'value' => @word.name,
      'label' => "#{@word.name} &ndash; <em>#{@word.local.translations.first}</em>"
    }]
  end

  it 'searches for words (w/ AJAX)' do
pending
    xhr :get, :search, :terms => @word, :locale => 'en'
p response.body
    response.should be_success
    response.should have_selector( 'li.word', :text => 'klama' )
  end
end
