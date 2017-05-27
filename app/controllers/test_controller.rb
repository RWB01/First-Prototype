class TestController < ApplicationController

  def start
    respond_to do |format|
        format.html { render :test }
    end
  end


  def step

    step_id = step_param
    current_step = nil

    @algorithm = Algorithm.find(1)
    @algorithm.steps.each do |x|
      if x.id.equal? step_id.to_i
        current_step = x
        break
      end
    end

    respond_to do |format|
      format.js {render "step", :locals => {:current_step => current_step }}
    end
  end

  private

    def step_param
      params.fetch(:step, nil)
    end

end
