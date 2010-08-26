class WordsController < ApplicationController
  skip_before_filter :authenticate_user!, :except => [:new, :create, :edit, :update, :destroy]
  before_filter :find_word, :only => [:show, :update, :destroy]

  def search
    @terms = (params[:terms] || '').split(%r{[ ,/]}, -1).map { |w|  w.strip.downcase }
    @words = Word.any_in( :name => @terms ).sort_by { |w|  @terms.index(w.name) }

    respond_to  do |format|
      format.html
      format.js do
        if @words.present?
          render @words
        else
          render :nothing => true
        end
      end
    end
  end

  def autocomplete
    terms = (params[:term] || '').split(' ', -1).map { |w|  w.strip.downcase }
    unless terms.last.present?
      render :json => []
      return
    end
    term = terms.slice!(-1)
    words = Word.any_of( {:name => /^#{term}/}, {'denotations.lang' => I18n.locale.to_s, 'denotations.translations' => term} ).asc(:name)

    results = words.map  do |word|
      label = word.name
      label += " &ndash; <em>#{word.local.translations.first}</em>"  if word.local.try(:translations).present?
      { 'id' => word.id.to_s, 'label' => label.html_safe, 'value' => (terms + [word.name]).join(' ') }
    end
    render :json => results
  end

  def index
    @letter = params[:l]
    @words = @letter.present? ? Word.where( :name => %r{^#{@letter}} ).asc(:name) : []
  end

  def show
    render :inline => '<%= render @word -%>', :layout => true
  end

#   def new
#   end
#
#   def create
#   end
#
#   def edit
#   end
#
#   def update
#   end
#
#   def destroy
#   end

protected
  def find_word
    id = BSON::ObjectId(params[:id].to_s) rescue nil
    if @word = (id ? Word.criteria.id(params[:id]) : Word.where(:name => params[:id].downcase)).first
      true
    else
      render :file => "#{Rails.root}/public/404.html", :layout => false, :status => 404
      false
    end
  end
end
