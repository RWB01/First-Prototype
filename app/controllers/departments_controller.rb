class DepartmentsController < ApplicationController

  before_action :set_department, only: [:show, :edit, :update, :destroy]

  def create
    @department = Department.new(department_params)

    respond_to do |format|
      if @department.save
        format.html { redirect_to @department, notice: 'Department was successfully created.' }
        format.json { render :show, status: :created, location: @department }
      else
        format.html { render :new }
        format.json { render json: @department.errors, status: :unprocessable_entity }
      end
    end
  end

  def new
    @department = Department.new
  end

  def index
    @departments = Department.all
  end

  def show
  end

  def update
    respond_to do |format|
      if @department.update(department_params)
        format.html { redirect_to @department, notice: 'Department was successfully updated.' }
        format.json { render :show, status: :ok, location: @department }
      else
        format.html { render :edit }
        format.json { render json: @department.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @department.destroy
    respond_to do |format|
      format.html { redirect_to communities_path, notice: 'Department was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def department_params
      params.required(:department).permit(:title, :alias)
    end

    def set_department
      @department = Department.find(params[:id])
    end
end
