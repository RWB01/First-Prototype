

document.addEventListener("turbolinks:load", function() {
	$(document).ready(function(){
		var steps = [];

		for (var i = 0; i < gon.steps.length; i++) {
			steps[gon.steps[i].line_number] = gon.steps[i].step_number;
		}

		//функция вызывается при попытке добавить/удалить шаг
		$(".algorithm-text-string-button").click(function(){
			var temp_step_line = parseInt(this.id.substring(12)); //12 = длина step_button_
			if ($(this).data("status") === "unchecked"){
				$(this).css("background-color", "#3498DB");
				$(this).data("status","checked");
				steps[temp_step_line] = 1;

			} else {
				$(this).css("background-color", "#c0392b");
				$(this).data("status","unchecked");			
				var delete_step_line = parseInt(this.id.substring(12)); //12 = длина step_button_
				steps[delete_step_line] = 0;
				$(this).html("Добавить шаг");
			}

			var temp_current_step_number = 1;
			
			for (var i = 1; i < steps.length; i++) {
	  			if (steps[i] !== undefined && steps[i] !== 0){
	  				steps[i] = temp_current_step_number;
	  				$("#step_button_" + i).html("Шаг " + temp_current_step_number);
	  				temp_current_step_number++;
	  			}
	  		}

		});	

		//функция вызывается при попытке свернуть/развернуть опции шага
		$(".step_options_button").click(function(){
			if ($(this).data("status") === "closed"){

				$(".step_options").hide(500);
				$(".step_options_button").data("status","closed");
				var temp_step_options_id = this.id.substring(20); //20 = длина step_options_button_

				$(this).data("status","opened");
				$("#step_options_" + temp_step_options_id).show(500);
			}
		});
	});
});
