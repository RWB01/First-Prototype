var steps = [];

function addStepOptions(step_number){
	str = "<div class=\"step\" id=\"step_" + step_number + '\">';
	str += "<div class=\"step_options_button\" data-status=\"closed\" id=\"step_options_button_" + step_number + "\">";
	str += "Шаг " + step_number;
	str += "</div>";
	str += "<div class=\"step_options\" id=\"step_options_" + step_number + '\">';
	str += "<form action=\"#\" id=\"form_" + step_number+ "\">";
	for (var i = 0; i < gon.variables.length; i++){
		str += "<label><input type=\"checkbox\" class=\"input_step_variables_checkbox\" id=\"step_" + step_number + "_variable_" + gon.variables[i].id + "\"" + "name=\"" + gon.variables[i].alias + "\"" + "value=\"" + gon.variables[i].id + "\">" + gon.variables[i].alias + "</label>";
	}
	str += "<label>Описание шага:<textarea  name=\"text\" class=\"step_description\" id=\"step_description_" + step_number + "\">" + "</textarea></label>";
	str += "<div>Следующие шаги:</div>";
	for (var i = 1; i < steps.length; i++){
		if (steps[i] !== undefined && steps[i] !== 0){
		str += "<div class=\"next_step_checkbox_wrapper\"><label><input type=\"checkbox\" class=\"next_step_checkbox\" id=\"next_step_" + steps[i] + "\" name=\"next_step\" value=\"" + steps[i] + "\"><span class=\"next_step_span\">Шаг " + steps[i]  + "</span></label></div>";
		}
	}
	str += "</form>";
	str += "</div>";
	str += "</div>" 
	return str;
}; 

function addNextStepToOptions(step_number){
	str = "<div class=\"next_step_checkbox_wrapper\"><label><input type=\"checkbox\" class=\"next_step_checkbox\" id=\"next_step_" + step_number + "\" name=\"next_step\" value=\"" + step_number + "\"><span class=\"next_step_span\">Шаг " + step_number  + "</span></label></div>";
	return str;
};                

document.addEventListener("turbolinks:load", function() {
	$(document).ready(function(){
		
		if (gon.steps != undefined){
			for (var i = 0; i < gon.steps.length; i++) {
				steps[gon.steps[i].line_number] = gon.steps[i].step_number;
			}
		}


		//функция вызывается при попытке добавить/удалить шаг
		$(".algorithm-text-string-button").click(function(){
			var temp_step_line = 0;
			var delete_step_number = 0;

			if ($(this).data("status") === "unchecked"){
				temp_step_line = parseInt(this.id.substring(12)); //12 = длина step_button_
				$(this).css("background-color", "#3498DB");
				$(this).data("status","checked");
				steps[temp_step_line] = 1;
			} else {
				$(this).css("background-color", "#c0392b");
				$(this).data("status","unchecked");			
				var delete_step_line = parseInt(this.id.substring(12)); //12 = длина step_button_
				delete_step_number = steps[delete_step_line];
				steps[delete_step_line] = 0;
				$(this).html("Добавить шаг");
			}

			var temp_current_step_number = 1;
			var added_step = 0;
			
			for (var i = 1; i < steps.length; i++) {
	  			if (steps[i] !== undefined && steps[i] !== 0){
	  				steps[i] = temp_current_step_number;
	  				if (temp_step_line === i){

	  					if (temp_current_step_number === 1){
	  						added_step = temp_current_step_number;
	  						console.log("added_step: " + added_step);
	  					} else {
	  						added_step = temp_current_step_number;
	  						console.log("added_step: " + added_step);
	  					}
	  				}
	  				$("#step_button_" + i).html("Шаг " + temp_current_step_number);
	  				temp_current_step_number++;				
	  			}
	  			
	  			if (steps[i] === 0){
	  				console.log("   delete_step_number: " + delete_step_number);
	  				steps[i] = undefined;
	  				$("#step_"+delete_step_number).remove();
	  			}
	  		}

	  		if (added_step === 1){
	  			$(".algorithm-steps-options").prepend(addStepOptions(added_step));
	  		} else {
	  			$("#step_" + (added_step-1)).after(addStepOptions(added_step));
	  		}

	  		console.log(steps);

	  		var k = 1;
	  		$(".step").each(function(){
	  			$(this).prop("id","step_"+k);
	  			$(this).find(".step_options_button").prop("id","step_options_button_" + k);
	  			$(this).find(".step_options_button").html("Шаг " + k);
	  			$(this).find(".step_options").prop("id","step_options_" + k);

	  			//здесь проходимся по каждому чекбоксу следующего шага в шаге
	  			var checked = [];
	  			var temp_step_number = 1;
	  			var is_deleted = false;
	  			var is_added = false;

		  			$(this).find(".next_step_checkbox_wrapper").each(function(){
		  				if (delete_step_number !== 0){
		  					//удаляем нужный чекбокс и нумеруем остальные по-порядку
		  					if (is_deleted === true){
		  						//здесь начинаем от айдишников шагов отнимать единичку
		  						$(this).find(".next_step_checkbox").prop("id", "next_step_" + (temp_step_number-1).toString());
		  						$(this).find(".next_step_span").html("Шаг " + (temp_step_number-1).toString());
		  						$(this).find(".next_step_checkbox").prop("value", (temp_step_number-1).toString());
		  					} else {
			  					if ($(this).find(".next_step_checkbox").prop("id") == "next_step_" + delete_step_number){
			  						//если находим чекбокс с удаляемым шагом, то ремуваем
			  						$(this).remove();
			  						is_deleted = true;
			  					}
		  					}
		  					temp_step_number++;
		  				}
		  				console.log(" k: " +  k + " added_step: " + added_step + " temp_step_number: "+ temp_step_number);
		  				if ((delete_step_number === 0) && (k !==added_step)){
		  					//console.log("Добавляем чекбокс " + (temp_step_number).toString() + " к шагу " + k);
		  					//если добавляем шаг, то добавляем ко всем шагам новые чекбоксы, правильно изменяя нумерацию
		  					if (is_added === true){
		  						//console.log("is_added: true | temp_step_number: " +  temp_step_number);
		  						$(this).find(".next_step_checkbox").prop("id", "next_step_" + (temp_step_number).toString());
		  						$(this).find(".next_step_span").html("Шаг " + (temp_step_number).toString());
		  						$(this).find(".next_step_checkbox").prop("value", (temp_step_number).toString());
		  					} else {
		  						if (added_step === temp_step_number){
		  							//console.log(" k: " +  k + " added_step: " + added_step + " temp_step_number: "+ temp_step_number);
		  							console.log("Добавляем чекбокс " + (added_step).toString() + " к шагу " + k);
		  							$(this).before(addNextStepToOptions(added_step));
		  							temp_step_number++;
		  							is_added = true;
		  							$(this).find(".next_step_checkbox").prop("id", "next_step_" + (temp_step_number).toString());
			  						$(this).find(".next_step_span").html("Шаг " + (temp_step_number).toString());
			  						$(this).find(".next_step_checkbox").prop("value", (temp_step_number).toString());
		  						} else {
		  							if (added_step === temp_step_number+1){
			  							$(this).after(addNextStepToOptions(added_step));
			  							temp_step_number++;
			  							is_added = true;
			  						}
		  						}
		  					}
		  					temp_step_number++;
		  				}
		  			});
	
	  			k++;
	  		});
		});	

		//функция вызывается при попытке свернуть/развернуть опции шага
		//работает И ДЛЯ динамически сгенерированных элементов
		$(document).on('click','.step_options_button',function(){
			if ($(this).data("status") === "closed"){

				$(".step_options").hide(500);
				$(".step_options_button").data("status","closed");
				var temp_step_options_id = this.id.substring(20); //20 = длина step_options_button_

				$(this).data("status","opened");
				$("#step_options_" + temp_step_options_id).show(500);
			}
		});


		//функция вызывается при нажатии чекбокса в поле выбора входных переменных алгоритма
		$(".input_variables_checkbox").click(function(){
			//alert("ПОЧАЛОСЯ");
		});


		//функция вызывается при нажатии чекбокса в поле выбора переменных шага
		//работает И ДЛЯ динамически сгенерированных элементов
		$(document).on('click','.input_step_variables_checkbox',function(){
			//alert("ПОЧАЛОСЯ в шаге");
		});

		$("#submit_algorithm_button").click(function(){
			var input_variables = [];
			$(".input_variables_checkbox").each(function(){
				var temp_input_variable = {};
				temp_input_variable.id = parseInt($(this).prop("value"));
				if ($(this).is(':checked')){
					temp_input_variable.is_input = true;
				} else {
					temp_input_variable.is_input = false;
				}
				input_variables.push(temp_input_variable);
			});
			//alert(input_variables);
			for (var i=0; i<input_variables.length;i++){
				console.log(input_variables[i].id + "    " + input_variables[i].is_input);
			}

			var data = {
				"input_variables": input_variables
			};

			$.ajax({
		        "url": gon.algorithm.id + "/change_options", 
		        "data": data,
		        "success": function () {
		            alert("Вроде сохранилось");
		        },
		        "type": 'post'
		    });
		});
	});
});
