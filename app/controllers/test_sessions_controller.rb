class TestSessionsController < ApplicationController
  before_action :set_test_session, only: [:show, :edit, :update, :destroy]

  # GET /test_sessions
  # GET /test_sessions.json
  def index
    if (current_user.has_role(:PROFESSOR_ROLE))
      @test_sessions = TestSession.where user_id: current_user.id
    else
      if (current_user.has_role(:STUDENT_ROLE))
        @test_sessions = TestSession.all.includes(:tests).where('tests.user_id' => current_user.id)
      end
    end
    # @user_test_results = []
    # TestResult.where(
    #     user_id: current_user.id,
    # ).find_each do |result|
    #   @user_test_results.push result
    # end
  end

  # GET /test_sessions/1
  # GET /test_sessions/1.json
  def show
  end

  # GET /test_sessions/new
  def new
    @test_session = TestSession.new

    @disciplines = User.find(current_user.id).disciplines #необходимо изменить так, чтобы искало только дисциплины преподавателя
    @groups = Group.all
    #gon.themes = Theme.all #необходимо изменить так, чтобы искало только темы дисциплин преподавателя
    @algorithms = Algorithm.all #необходимо изменить так, чтобы искало только алгоритмы преподавателя
    #gon.variables = Variable.all
    #gon.data_structures = DataStructure.all # ну вы понели
    gon.algorithms = []
    @disciplines.each do |discipline|
      discipline.themes.each do |theme|
        theme.algorithms.each do |algorithm|
          gon.algorithms << algorithm
        end
      end
    end

    gon.students = []
    @groups.each do |group|
      group.users.each do |user|
        student_hash = {'group_id' => group.id, 'user_id' => user.id, 'email' => user.email}
        gon.students << student_hash
      end
    end
  end

  # отрисовываем формы студентов
  def draw_students_forms
    students = Group.find(params[:group_id]).users
    respond_to do |format|
      format.js { render :draw_student_cards, :locals => {:students => students}}
    end
  end

  # отрисовываем формы ввода входных данных для каждого алгоритма
  def select_algorithms
    data_array = params[:data_array]
    # if (!data_array.nil?)
    #   data_array.each do |key,val|
    #   end
    # end
    respond_to do |format|
      format.js { render :add_input_data_forms, :locals => {:data_array => data_array} }
    end
  end

  # GET /test_sessions/1/edit
  def edit
  end

  #вкидываем 1 алгоритм в сеанс тестирования
  def add_one_algorithm
    require 'date'
    @algorithm = Algorithm.find(params[:algorithm])
    input_variables = @algorithm.variables.reject{|x| !x.is_input}
      respond_to do |format|
        format.js { render :add_one_algorithm, :locals => {:variables => input_variables, :algorithm => @algorithm }}
      end
  end

  def save_test_session
    if (!params[:tests].nil?)
      test_session = TestSession.new(:test_date => params[:date].to_date(), :time => params[:time], :estimation_formula => params[:formula], :user_id => current_user.id, :discipline_id => params[:discipline], :group_id => params[:group])
      test_session.save
      test_session.create_tests(params[:tests])
    end
  end



  #сохраняем сеанс тестирования
  def appoint_test_session
      test_session = TestSession.new(:test_date => params[:date].to_date(), :time => params[:time], :estimation_formula => params[:formula])
      test_session.save
      if params[:input_type] == "manual"
        test_session.manual_tests(params[:numbers], params[:strings], params[:vectors], params[:matrixs], params[:group], params[:algorithm])
      end

      if params[:input_type] == "generate"
        test_session.generate_tests(params[:group],params[:algorithm])
      end
      respond_to do |format|
        format.js 
      end
  end

  # POST /test_sessions
  # POST /test_sessions.json
  def create
    @test_session = TestSession.new(test_session_params)

    respond_to do |format|
      if @test_session.save
        format.html { redirect_to @test_session, notice: 'Test session was successfully created.' }
        format.json { render :show, status: :created, location: @test_session }
      else
        format.html { render :new }
        format.json { render json: @test_session.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /test_sessions/1
  # PATCH/PUT /test_sessions/1.json
  def update
    respond_to do |format|
      if @test_session.update(test_session_params)
        format.html { redirect_to @test_session, notice: 'Test session was successfully updated.' }
        format.json { render :show, status: :ok, location: @test_session }
      else
        format.html { render :edit }
        format.json { render json: @test_session.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /test_sessions/1
  # DELETE /test_sessions/1.json
  def destroy
    @test_session.destroy
    respond_to do |format|
      format.html { redirect_to test_sessions_url, notice: 'Test session was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_test_session
      @test_session = TestSession.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def test_session_params
      params.require(:test_session).permit(:test_date, :time)
    end
end
