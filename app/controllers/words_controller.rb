class WordsController < ApplicationController
  before_action :set_word, only: [:show, :edit, :update, :destroy, :save_meanings]

  # GET /words
  # GET /words.json
  def index
    @words = Word.all.includes(:meanings)
  end

  # GET /words/1
  # GET /words/1.json
  def show
  end

  # POST /words/1
  def save_meanings
    respond_to do |format|
      if @word.update_meanings(params)
        format.html { redirect_to @word, notice: 'Word was successfully updated.' }
        format.json { render :show, status: :ok, location: @word }
      else
        format.html { render :edit }
        format.json { render json: @word.errors, status: :unprocessable_entity }
      end
    end
  end

  # GET /words/new
  def new
    @word = Word.new
    @word.word_tags.build
  end

  # GET /words/1/edit
  def edit
    @word.word_tags.new
  end

  # POST /words
  # POST /words.json
  def create
    @word = Word.new(word_params)

    respond_to do |format|
      if @word.save
        format.html { redirect_to @word, notice: 'Word was successfully created.' }
        format.json { render :show, status: :created, location: @word }
      else
        format.html { render :new }
        format.json { render json: @word.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /words/1
  # PATCH/PUT /words/1.json
  def update
    respond_to do |format|
      if @word.update(word_params)
        format.html { redirect_to @word, notice: 'Word was successfully updated.' }
        format.json { render :show, status: :ok, location: @word }
      else
        format.html { render :edit }
        format.json { render json: @word.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /words/1
  # DELETE /words/1.json
  def destroy
    @word.destroy
    respond_to do |format|
      format.html { redirect_to words_url, notice: 'Word was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_word
      @word = Word.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def word_params
      params.fetch(:word, {}).permit(:picture, word_tags_attributes: [:id, :tag_id, :_destroy])
      # params.require(:word).permit(:picture, :word_tags)
    end
end
