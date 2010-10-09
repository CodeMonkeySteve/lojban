require 'spec_helper'

describe WordsController do
  include Devise::TestHelpers
  render_views

  before do
    @word = Factory.create :word
  end
  it 'renders the index page' do
    get :index, :locale => 'en', :letter => @word.name[0]
    response.should be_success
    response.should render_template('words/index')
    response.should have_selector( 'div.word span.name', :content => @word.name )
  end

  it 'renders the show page' do
    get :show, :id => @word.name, :locale => 'en'
    response.should be_success
    response.should render_template('words/_word')
    response.should have_selector( 'div.word', :content => @word.name )
  end

  it 'renders the search page' do
    get :search, :locale => 'en', :terms => 'klama'
    response.should be_success
    response.should render_template('words/search')
    response.should have_selector( 'div#words.words div.word', :content => @word.name )
  end

  it 'auto-completes a word (w/ AJAX)' do
    xhr :get, :autocomplete, :term => @word.name[0...-1], :locale => 'en'
    response.should be_success
    ActiveSupport::JSON.decode(response.body).should == [{
      'id' => @word.id.to_s, 'value' => @word.name,
      'label' => "#{@word.name} &ndash; <em>#{@word.local.translations.first}</em>"
    }]
  end
end
