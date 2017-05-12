class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy, :add_role, :remove_role, :add_discipline, :remove_discipline]
  # Helpful filter to access
  # before_filter :authenticate_user!, :except => [:show, :index]
  before_filter :authenticate_user!

  # GET /users
  # GET /users.json
  def index
     @users = User.all
  end

  # GET /users/1
  # GET /users/1.json
  def show
    roles = Role.all
    ids = @user.roles.map{|x| x.id}
    filtered_roles = roles.reject{|x| ids.include? x.id}

    disciplines = Discipline.all
    discipline_ids = @user.disciplines.map{|x| x.id}
    filtered_disciplines = disciplines.reject{|x| discipline_ids.include? x.id}

    render :show, :locals => {:roles => filtered_roles, :disciplines => filtered_disciplines}
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def add_role
    if !(id = user_role_param).nil?
      role = Role.find(id)
      @user.roles << role
    end
    redirect_to action: :show, id: @user.id
  end

  def remove_role
    if !(id = user_role_param).nil?
      role = Role.find(id)
      @user.roles.delete(role)
    end
    redirect_to action: :show, id: @user.id
  end

  def add_discipline
    if !(id = user_discipline_param).nil?
      discipline = Discipline.find(id)
      @user.disciplines << discipline
    end
    redirect_to action: :show, id: @user.id
  end

  def remove_discipline
    if !(id = user_discipline_param).nil?
      discipline = Discipline.find(id)
      @user.disciplines.delete(discipline)
    end
    redirect_to action: :show, id: @user.id
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.fetch(:user, {})
    end

    def user_role_param
      params.fetch(:role, nil)
    end

    def user_discipline_param
      params.fetch(:discipline, nil)
    end
end
