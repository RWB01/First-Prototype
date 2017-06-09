class TestController < ApplicationController

  before_action :set_algorithm, only: [:start, :step]

  def start

    current_step = @algorithm.steps[0]

    respond_to do |format|
        #current_step nil because it's initial step
        format.html { render :test, :locals => {:current_step => current_step }}
    end

  end


  def step

    step_id = params[:step_id]

    current_step = nil

    @algorithm.steps.each do |x|

      if x.id.equal? step_id.to_i
        current_step = x
        break
      end

    end

    if !current_step.nil?
      respond_to do |format|
        format.js {render :step, :locals => {:current_step => current_step }}
      end
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
