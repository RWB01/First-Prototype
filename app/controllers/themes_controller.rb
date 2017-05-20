class ThemesController < ApplicationController
  before_action :set_theme, only: [:show, :edit, :update, :destroy]

  # GET /themes
  # GET /themes.json
  def index
    @discipline = Discipline.find(params[:discipline_id])
    @themes = @discipline.themes
  end

  # GET /themes/1
  # GET /themes/1.json
  def show
  end

  # GET /themes/new
  def new
    @theme = Theme.new
    @discipline = Discipline.find(params[:discipline_id])
    @theme.discipline_id = @discipline.id
  end

  # GET /themes/1/edit
  def edit
    @discipline = Discipline.find(@theme.discipline.id)
  end

  # POST /themes
  # POST /themes.json
  def create
    @discipline = Discipline.find(params[:discipline_id])
    @theme = Theme.new(theme_params)
    respond_to do |format|
      if @theme.save
        format.html { redirect_to @theme, notice: 'Theme was successfully created.' }
        format.json { render :show, status: :created, location: @theme }
      else
        format.html { render :new }
        format.json { render json: @theme.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /themes/1
  # PATCH/PUT /themes/1.json
  def update
    respond_to do |format|
      
      if @theme.update(theme_params)
        format.html { redirect_to @theme, notice: 'Theme was successfully updated.' }
        format.json { render :show, status: :ok, location: @theme }
      else
        format.html { render :edit }
        format.json { render json: @theme.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /themes/1
  # DELETE /themes/1.json
  def destroy
    discipline_id = @theme.discipline.id
    @theme.destroy

    respond_to do |format|
      format.html { redirect_to discipline_themes_url(discipline_id), notice: 'Theme was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_theme
      @theme = Theme.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def theme_params
      params.require(:theme).permit(:title, :alias, :discipline_id)
    end
end
