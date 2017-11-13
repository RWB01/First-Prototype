//должно вызываться при нажатии на тему и при нажатии на алгоритм 
function addAlgorithmToLists(algorithm_id) {
	var title = gon.algorithms.find(x => x.id == algorithm_id).title;
	$(".algorithm_select").each(function(){
		this.append(new Option(title, algorithm_id));
	})
}

function deleteAlgorithmFromLists(algorithm_id) {
	$('.algorithm_select option[value="' + algorithm_id + '"]:selected',).each(function(){
		$(this).parent().parent().parent().find(".algorithm_description_block").html("");
		$(this).siblings('option[value=""]').prop("selected",true);
		$("#student_buttons_" + $(this).parent().prop('id').split("_").pop()).hide();
		alert($(this).parent().prop('id').split("_").pop());
		$("#student_variables_" + $(this).parent().prop('id').split("_").pop()).html("");
	})

	$('.algorithm_select option[value="' + algorithm_id + '"]').remove();
}

function randomInteger(min, max) {
    var rand = min - 0.5 + Math.random() * (max - min + 1)
    rand = Math.round(rand);
    return rand;
}

function sendStudentsAlgorithms(students, algorithms) {
	var overused_algorithms = [];
	var data_array = [];
	students.forEach(function(item, i, arr) {
		var temp_obj = {};
		if (algorithms.length == 0) {
			algorithms = overused_algorithms.slice(0);
			  	overused_algorithms = [];
		}
		var random_number = randomInteger(0,algorithms.length-1);
		temp_obj.algorithm = algorithms[random_number];
		overused_algorithms.push(algorithms[random_number]);
		algorithms.splice(random_number,1);
		temp_obj.student = item;
		data_array.push(temp_obj);
	});

	var data = {
		"data_array": data_array,
	};

	$.ajax({
		"url": "/test_sessions/select_algorithms", 
		"data": data,
		"success": function(){},
		"type": 'post'
	});		
}


function randomString(length) {
	var chars = ' abcdefghijklmnopqrstuvwxyz';
	//var chars = ' 0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ';
    var result = '';
    for (var i = length; i > 0; --i) 
    	result += chars[Math.floor(Math.random() * chars.length)];
    return result;
}


function generateInputData(variable) {
		if ($(variable).data("type") == "number") {
			var min_value = parseInt($(variable).data("minValue"));
			var max_value = parseInt($(variable).data("maxValue"));
			$(variable).find(".input_cell").val(randomInteger(min_value,max_value));
			$(variable).find(".input_cell").removeClass("error_cell");
		}

		if ($(variable).data("type") == "vector") {
			var min_value = parseInt($(variable).data("minValue"));
			var max_value = parseInt($(variable).data("maxValue"));
			$(variable).find(".input_cell").each(function() {
				$(this).val(randomInteger(min_value,max_value));
				$(this).removeClass("error_cell");
			})
		}

		if ($(variable).data("type") == "matrix") {
			var min_value = parseInt($(variable).data("minValue"));
			var max_value = parseInt($(variable).data("maxValue"));
			$(variable).find(".input_cell").each(function() {
				$(this).val(randomInteger(min_value,max_value));
				$(this).removeClass("error_cell");
			})
		}

		if ($(variable).data("type") == "string") {
			var min_length = parseInt($(variable).data("minLength"));
			var max_length = parseInt($(variable).data("maxLength"));
			$(variable).find(".input_string_cell").val(randomString(randomInteger(min_length,max_length)));
			$(variable).find(".input_string_cell").removeClass("error_cell");
		}
}


//обработка кнопки очистки всех форм
$("#reset_all_forms_button").click(function() {

});


//обработка кнопки сохранения сеанса тестирования
$(document).on('click','#submit_test_session_button',function(){
	var empty_flag = false;
	var error_flag = false;
	var students_not_selected_error = true;
	var algorithm_not_selected = false;
	var students = [];

	//var students = [];
	//alert("Почалося");
	$(".student_checkbox:checked").each(function(){
		students_not_selected_error = false;
		students.push(this.value);
		if ($("#algorithm_select_" + this.value + " option:selected[value='']").val() == "") {
			algorithm_not_selected = true;
		} else {
			$("#student_variables_" + this.value).each(function() {
				$(this).find(".empty_cell").each(function() {
					empty_flag = true;
				})
				$(this).find(".error_cell").each(function() {
					error_flag = true;
				})
			})
		}
	})

	if (students_not_selected_error) {
		alert("Ошибка: Не был выбран ни один студент");
	} else {
		if (algorithm_not_selected) {
			alert("Ошибка: не был выбран алгоритмт");
		} else {
			if (empty_flag || error_flag) {
				alert("Ошибка: Форма ввода содержит пустые или неправильные значения");
			} else {
				//вот тута начинаем собирать данные!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

				//собираем дату
				var date = "";
				date = $("#test_date").val();

				//собираем время тестирования
				var test_time;
				time = $("#test_time").val();

				//собираем группу
				var group;
				group = $("#group_select").val();

				//собираем дисциплину
				var discipline = $("#discipline_select").val();
				
				//собираем способ оценивания
				var formula;
				formula = $("#formula_select").val();

				var tests = [];

				//собираем студентов, алгоритмы и входные данные
				students.forEach(function(item, i, arr) { 
					var test = {};
					test.student = item;
					test.algorithm = $("#algorithm_select_" + item + " option:selected").val();
					test.variables = [];
					$("#student_variables_" + item).find(".variable").each(function() {
						var temp_variable = {};
						temp_variable.id = $(this).data("variableId");
						temp_variable.value = "";

						if ($(this).data("type") == "number") {
							temp_variable.value = $(this).find(".number_cell").val();
							temp_variable.type = "number";
							test.variables.push(temp_variable);
						}

						if ($(this).data("type") == "vector") {
							temp_variable.value = "[";
							$(this).find(".vector_cell").each(function() {
								temp_variable.value += $(this).val() +",";
							})
							temp_variable.value = temp_variable.value.slice(0, -1);
							temp_variable.value += "]";
							temp_variable.type = "vector";
							test.variables.push(temp_variable);
						}

						if ($(this).data("type") == "matrix") {
							temp_variable.value += "[";
							$(this).find(".matrix_row").each(function(){
								temp_variable.value += "[";
								$(this).find(".matrix_cell").each(function(){
									temp_variable.value += $(this).val() +",";
								});
								temp_variable.value = temp_variable.value.slice(0, -1);
								temp_variable.value += "]";
								temp_variable.value += ",";
							});
							temp_variable.value = temp_variable.value.slice(0, -1);
							temp_variable.value += "]";
							temp_variable.type = "matrix";
							test.variables.push(temp_variable);
						}

						if ($(this).data("type") == "string") {
							temp_variable.value = $(this).find(".string_cell").val();
							temp_variable.type = "string";
							test.variables.push(temp_variable);
						}
					})
					
					tests.push(test);
				})

				var data = {
					"date": date,
					"time": time,
					"group": group,
					"discipline": discipline,
					"formula": formula,
					"tests": tests
				};

				$.ajax({
			        "url": "/test_sessions/save_test_session", 
			        "data": data,
			        "success": function () {
			            alert("Сеанс тестирования сохранён");
			        },
			        "type": 'post'
			    });
			}
		}
	}

});


//рандомно заполняем карточки студентов рандомными алгоритмами, затем рандомными входными данными, максимум рандома!
$(document).on('click','#fill_forms_button',function(){
	var algorithms = [];
	var students = [];
			
	//var data_array = [];
	$(".algorithm_checkbox:checked").each(function(){
		algorithms.push(this.value);
	})

	$(".student_checkbox:checked").each(function(){
		students.push(this.value);
	})

	//собираем пары {алгоритм_id,студент_id} и посылаем их на сервер, чтобы отрендерить формы ввода данных
	if (algorithms != 0 && students != 0) {
		sendStudentsAlgorithms(students,algorithms);
	}
});


document.addEventListener("turbolinks:load", function() {
	$(document).ready(function(){
		//обработка выбора дисциплины
		$( "#discipline_select" ).change(function() {
			//прячем все темы
			$(".discipline_wrapper").hide(100);
			$(".theme_algorithms_wrapper").hide(100);
			$(".theme_checkbox").prop('checked', false);
			$(".algorithm_checkbox").prop('checked', false);
			//показываем темы выбранной дисциплины
			$("#discipline_"+this.value).show(100);
			$("#discipline_notification_unselected").hide(100);
			$("#discipline_notification_selected").show(100);
			//активируем кнопочки
			//alert($("#group_select").val() != undefined);
			if ($("#group_select").val() != undefined) {
				$("#reset_all_forms_button").prop( "disabled", false );
				$("#fill_forms_button").prop( "disabled", false );
				$("#submit_test_session_button").prop( "disabled", false );
			}
		});
		
		//обработка чекбокса выбора темы
		$('.theme_checkbox').change(function() {
	        if(this.checked) {
	            $(this).parent().parent().find(".theme_algorithms_wrapper").show(100);
	            //тут мы выставляем все галочки в алгоритмах темы
	            $(this).parent().parent().find(".algorithm_checkbox:enabled").prop('checked', true);
	            //тут при добавлении темы должны добавиться все её алгоритмы в поле выбора в карточках студентов
	            $(this).parent().parent().find(".algorithm_checkbox").each(function(){
	            	addAlgorithmToLists(this.value);
	            })
	        }      
	        if(!this.checked) {
	            $(this).parent().parent().find(".theme_algorithms_wrapper").hide(100);
	            //тут мы убираем все галочки в алгоритмах темы
	            $(this).parent().parent().find(".algorithm_checkbox").prop('checked', false);
	            //тут при удалении темы должны исчезнуть все её алгоритмы в поле выбора в карточках студентов
	            $(this).parent().parent().find(".algorithm_checkbox").each(function(){
	            	deleteAlgorithmFromLists(this.value);
	            })
	        }    
	    });

	    //обработка чекбокса выбора алгоритма
		$('.algorithm_checkbox').change(function() {
			//если мы включаем чекбокс, то алгоритм появляется в поле выбора в карточках студентов
			if (this.checked){
				addAlgorithmToLists(this.value);
			}

			//если мы выключаем чекбокс, то алгоритм исчезает из соответствующего поля выбора в карточках студентов
			if (!this.checked){
				deleteAlgorithmFromLists(this.value);
				var alg_wrapper = $(this).parent().parent();
				if (!alg_wrapper.find(".algorithm_checkbox:checked").length) {
					alg_wrapper.parent().find(".theme_checkbox").prop('checked', false);
					alg_wrapper.hide(100);
				}
				//а так же, если алгоритм был у кого-то выбран, то исчезают его поля ввода и карточка обнуляется
			}
			
		});

		//обработка выбора группы
		$("#group_select").change(function() {
			var group_id = $(this).val();
			var data = {
				"group_id": group_id,
			};

			$.ajax({
			    "url": "/test_sessions/draw_students_forms", 
			    "data": data,
			    "success": function(){},
			    "type": 'post'
			});

			$("#group_notification_selected").show(100);
			$("#group_notification_unselected").hide(100);

			//активируем кнопочки
			if ($("#discipline_select").val() != undefined) {
				$("#reset_all_forms_button").prop( "disabled", false );
				$("#fill_forms_button").prop( "disabled", false );
				$("#submit_test_session_button").prop( "disabled", false );
			}

		});




	});
});