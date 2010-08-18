class WordsController < ApplicationController
  skip_before_filter :authenticate_user!, :only => [:index, :search, :show]
  before_filter :find_word, :only => [:show, :update, :destroy]

  def search
    @words = params[:term].blank? ? [] : Word.where( :name => /^#{params[:term]}/ ).limit(10)
    respond_to  do |format|
      format.html
      format.json do
        render :json => @words.map { |w|  { 'id' => w.id, 'label' => w.name, 'value' => w.name } }
      end
    end
  end

  def index
    page = params[:p].to_i.zero? ? 1 : params[:p].to_i
    @words = Word.all.asc( :name ).paginate( :page => page, :per_page => 100 )
  end

  def show
  end

  def new
  end

  def create
  end

  def edit
  end

  def update
  end

  def destroy
  end

protected
  def find_word
    id = BSON::ObjectID(params[:id].to_s) rescue nil
    if @word = (id ? Word.criteria.id(params[:id]) : Word.where(:name => params[:id])).first
      true
    else
      render :file => "#{Rails.root}/public/404.html", :layout => false, :status => 404
      false
    end
  end

end
