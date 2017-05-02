class GroupsController < ApplicationController

  before_action :set_group, only: [:show, :edit, :update, :destroy]

  # POST /groups
  # POST /groups.json
  def create
    @group = Group.new(group_params)

    respond_to do |format|
      if @group.save
        format.html { redirect_to @group, notice: 'Group was successfully created.' }
        format.json { render :show, status: :created, location: @group }
      else
        format.html { render :new }
        format.json { render json: @group.errors, status: :unprocessable_entity }
      end
    end
  end

  def new
    @group = Group.new
  end

  def index
    @groups = Group.all
  end

  def update
    respond_to do |format|
      if @group.update(group_params)
        format.html { redirect_to @group, notice: 'Group was successfully updated.' }
        format.json { render :show, status: :ok, location: @group }
      else
        format.html { render :edit }
        format.json { render json: @group.errors, status: :unprocessable_entity }
      end
    end
  end

  def show
  end

  def destroy
    @group.destroy
    respond_to do |format|
      format.html { redirect_to communities_path, notice: 'Group was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def group_params
      params.required(:group).permit(:title, :alias)
    end

    def set_group
      @group = Group.find(params[:id])
    end
end
