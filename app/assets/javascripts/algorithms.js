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
	for (var i = 1; i < steps.length; i++){
		if (steps[i] !== undefined && steps[i] !== 0){
		str += "<div class=\"next_step_checkbox_wrapper\"><label><input type=\"checkbox\" class=\"next_step_checkbox\" id=\"next_step_" + steps[i] + "\" name=\"next_step\" value=\"" + steps[i] + "\"> Шаг " + steps[i]  + "</label></div>";
		}
	}
	str += "</form>";
	str += "</div>";
	str += "</div>" 
	return str;
};                    

document.addEventListener("turbolinks:load", function() {
	$(document).ready(function(){
		

		for (var i = 0; i < gon.steps.length; i++) {
			steps[gon.steps[i].line_number] = gon.steps[i].step_number;
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
	  						$(".algorithm-steps-options").prepend(addStepOptions(temp_current_step_number));
	  						added_step = temp_current_step_number;
	  						console.log("added_step: " + added_step);
	  					} else {
	  						$("#step_" + (temp_current_step_number-1)).after(addStepOptions(temp_current_step_number));
	  						added_step = temp_current_step_number;
	  						console.log("added_step: " + added_step);
	  					}
	  				}


					//steps[i] = temp_current_step_number;
	  				$("#step_button_" + i).html("Шаг " + temp_current_step_number);
	  				temp_current_step_number++;				
	  			}
	  			
	  			if (steps[i] === 0){
	  				//console.log("i: " + i);
	  				//console.log("   steps[i]:" +steps[i]);
	  				//console.log("   delete_step_line: " + delete_step_line);
	  				//console.log("   delete_step_number: " + delete_step_number);
	  				steps[i] = undefined;
	  				$("#step_"+delete_step_number).remove();
	  			}
	  		}

	  		var k = 1;
	  		$(".step").each(function(){
	  			$(this).prop("id","step_"+k);
	  			$(this).find(".step_options_button").prop("id","step_options_button_" + k);
	  			$(this).find(".step_options_button").html("Шаг " + k);
	  			$(this).find(".step_options").prop("id","step_options_" + k);

	  			//здесь проходимся по каждому чекбоксу следующего шага в шаге
	  			var checked = [];
	  			$(this).find(".next_step_checkbox_wrapper").each(function(){
	  				if (delete_step_number !== 0){
	  					//удаляем нужный чекбокс и нумеруем остальные по-порядку
	  				}
	  				if (delete_step_number === 0){
	  					//если добавляем шаг, то добавляем ко всем шагам новые чекбоксы, правильно изменяя нумерацию
	  				}
	  			});

	  			//           вооооооооооооооооооооооооооот                               ВОООООООООООТ ОТСЮДА ВОТ
/*	  			var checked = [];
	  			var z = 1;

	  			$(this).find(".next_step_checkbox").each(function(){
	  				if($(this).prop('checked')){
	  					checked[z] = true;
	  				} else {
	  					checked[z] = false;
	  				}
	  				z++;
	  			});

	  			$(this).find(".next_step_checkbox_wrapper").remove();
	  			for (var m = 1; m < steps.length; m++){
	  				str = "";
					if (steps[m] !== undefined && steps[m] !== 0){
						str += "<div class=\"next_step_checkbox_wrapper\"><label><input type=\"checkbox\" class=\"next_step_checkbox\" id=\"next_step_" + steps[m] + "\" name=\"next_step\" value=\"" + steps[m] + "\"> Шаг " + steps[m]  + "</label></div>";
					}
					$(this).find("form").append(str);
				}*/
				//  ППППППППППППППППППООООООООООООООООООООООООООООООО СЮДА ВОТ ПОД ВОПРОСОМ ЭТО ВСЁ. Лучше попробовать appendить\удалять шаги по одному, изменяя при этом номера\id шагов
	  			
	  			k++;
	  		});

	  		//$(".next_step_checkbox").each(function(){

	  		//});
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
			alert("ПОЧАЛОСЯ");
		});


		//функция вызывается при нажатии чекбокса в поле выбора переменных шага
		//работает И ДЛЯ динамически сгенерированных элементов
		$(document).on('click','.input_step_variables_checkbox',function(){
			alert("ПОЧАЛОСЯ в шаге");
		});
	});
});
