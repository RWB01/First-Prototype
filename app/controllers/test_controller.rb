class TestController < ApplicationController

  before_action :set_algorithm, only: [:start, :step]

  def start

    respond_to do |format|
        #current_step nil because it's initial step
        format.html { render :test, :locals => {:current_step => nil }}
    end

  end


  def step

    step_id = params[:step_id]

    current_step = nil

    @algorithm.steps.each do |x|

      if x.step_number.equal? step_id.to_i
        current_step = x
        break
      end

    end

    if !current_step.nil?
      respond_to do |format|
        format.js { render :step, :locals => {:current_step => current_step }}
      end
    else
      redirect_to :result_test
    end

  end

  def result
    respond_to do |format|
      format.html { render :end }
    end
  end

  private

    def set_algorithm
      @algorithm = Algorithm.find(params[:algorithm_id].to_i)
    end

    # def step_params
    #   params.fetch
    # end

end
