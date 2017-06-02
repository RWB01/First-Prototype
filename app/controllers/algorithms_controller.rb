class AlgorithmsController < ApplicationController
  before_action :set_algorithm, only: [:show, :edit, :update, :destroy]

  # GET /algorithms
  # GET /algorithms.json
  def index   
    @theme = Theme.find(params[:theme_id])
    @algorithms = @theme.algorithms
  end

  # GET /algorithms/1
  # GET /algorithms/1.json
  def show
    temp_code = @algorithm.code_contents.split("//end of variables descriptions")
    @code = temp_code[-1].strip.split("\n")
    gon.algorithm = @algorithm
  end

  # GET /algorithms/new
  def new
    @algorithm = Algorithm.new
    @theme = Theme.find(params[:theme_id])
    @algorithm.theme_id = @theme.id
  end

  # GET /algorithms/1/edit
  def edit
    @theme = @algorithm.theme
  end

  # POST /algorithms
  # POST /algorithms.json
  def create
    @theme = Theme.find(params[:theme_id])
    @algorithm = Algorithm.new(algorithm_params)

    # Parsing variables in file
    # Should change it later to parse better to exclude errors
    if @algorithm.save
      temp_code = @algorithm.code_contents.split("//end of variables descriptions")
      variables_descriptions = temp_code[0].strip.split("\n")
      
      variables_descriptions.each do |variable|
        splitted_variable = variable.strip.split(%r{\s+})
        search_word = splitted_variable[0].delete '/'
        search_word = search_word.upcase
        data_structure = DataStructure.find_by alias: search_word
        new_variable = Variable.new(:alias => splitted_variable[1], :name => splitted_variable[1], :limitation => splitted_variable[2], :data_structure_id => data_structure.id, :algorithm_id => @algorithm.id)
        new_variable.save
      end
    end

    respond_to do |format|
      if @algorithm.save
        format.html { redirect_to @algorithm, notice: 'Algorithm was successfully created.' }
        format.json { render :show, status: :created, location: @algorithm }
      else
        format.html { render :new }
        format.json { render json: @algorithm.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /algorithms/1
  # PATCH/PUT /algorithms/1.json
  def update
    respond_to do |format|
      if @algorithm.update(algorithm_params)
        format.html { redirect_to @algorithm, notice: 'Algorithm was successfully updated.' }
        format.json { render :show, status: :ok, location: @algorithm }
      else
        format.html { render :edit }
        format.json { render json: @algorithm.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /algorithms/1
  # DELETE /algorithms/1.json
  def destroy
    theme = @algorithm.theme
    @algorithm.destroy
    respond_to do |format|
      format.html { redirect_to theme_algorithms_url(theme), notice: 'Algorithm was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_algorithm
      @algorithm = Algorithm.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def algorithm_params
      params.require(:algorithm).permit(:title, :description, :theme_id, :code)
    end
end
