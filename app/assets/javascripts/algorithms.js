var steps = [];

$(document).ready(function(){
	$(".algorithm-text-string-button").click(function(){
		//$(this).hide();
		//alert($(this).data("status"));
		var temp_step_line = parseInt(this.id.substring(12));;
		if ($(this).data("status") === "unchecked"){
			$(this).css("background-color", "#3498DB");
			$(this).data("status","checked");
			steps[temp_step_line] = 1;

		} else {
			$(this).css("background-color", "#c0392b");
			$(this).data("status","unchecked");			
			var delete_step_line = parseInt(this.id.substring(12));
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
});

