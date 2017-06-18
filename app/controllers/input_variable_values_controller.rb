class InputVariableValuesController < ApplicationController
  before_action :set_input_variable_value, only: [:show, :edit, :update, :destroy]

  # GET /input_variable_values
  # GET /input_variable_values.json
  def index
    @input_variable_values = InputVariableValue.all
  end

  # GET /input_variable_values/1
  # GET /input_variable_values/1.json
  def show
  end

  # GET /input_variable_values/new
  def new
    @input_variable_value = InputVariableValue.new
  end

  # GET /input_variable_values/1/edit
  def edit
  end

  # POST /input_variable_values
  # POST /input_variable_values.json
  def create
    @input_variable_value = InputVariableValue.new(input_variable_value_params)

    respond_to do |format|
      if @input_variable_value.save
        format.html { redirect_to @input_variable_value, notice: 'Input variable value was successfully created.' }
        format.json { render :show, status: :created, location: @input_variable_value }
      else
        format.html { render :new }
        format.json { render json: @input_variable_value.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /input_variable_values/1
  # PATCH/PUT /input_variable_values/1.json
  def update
    respond_to do |format|
      if @input_variable_value.update(input_variable_value_params)
        format.html { redirect_to @input_variable_value, notice: 'Input variable value was successfully updated.' }
        format.json { render :show, status: :ok, location: @input_variable_value }
      else
        format.html { render :edit }
        format.json { render json: @input_variable_value.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /input_variable_values/1
  # DELETE /input_variable_values/1.json
  def destroy
    @input_variable_value.destroy
    respond_to do |format|
      format.html { redirect_to input_variable_values_url, notice: 'Input variable value was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_input_variable_value
      @input_variable_value = InputVariableValue.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def input_variable_value_params
      params.require(:input_variable_value).permit(:value, :variable_id)
    end
end
