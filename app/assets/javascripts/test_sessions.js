function addTest(algorithm_name, input_variables){
	str = "";
	str += "<div class=\"test\">";
	str += "<div class=\"algorithm_title\">" + algorithm_name + "</div>"
	str += "<div class=\"input_variables\">" + input_variables + "</div>";
	str += "<div class=\"delete_button\"><button class=\"delete_test\">Удалить тест</button></div>";
	str += "</div>";
	return str;
}

document.addEventListener("turbolinks:load", function() {
	$(document).ready(function(){
		
		//функция вызывается при нажатии на имя дисциплины
		$(document).on('click','.discipline_name',function(){
			if ($(this).data("status") === "closed"){
				$(".theme_list").hide(200);
				$(".algorithm_list").hide(200);
				$(".discipline_name").data("status","closed");
				$(this).parent().find(".theme_list").show(200);
				$(this).data("status","opened");
			} else {
				$(this).parent().find(".theme_list").hide(200);
				$(this).data("status","closed");
			}
		});


		//функция вызывается при нажатии на имя темы
		$(document).on('click','.theme_name',function(){
			if ($(this).data("status") === "closed"){
				$(".algorithm_list").hide(200);
				$(".theme_name").data("status","closed");
				$(this).parent().find(".algorithm_list").show(200);
				$(this).data("status","opened");
			} else {
				$(this).parent().find(".algorithm_list").hide(200);
				$(this).data("status","closed");
			}
		});


		//функция вызывается при переключении радиобаттона выбора задания входных данных
		$(document).on('change','input[type=radio][name=input_type]',function(){
			if (this.value == "manual"){
				$(".variable_field").show(100);
			}
			if (this.value == "generate"){
				$(".variable_field").hide(100);
			}
		});


		$(document).on('click','#cancel_algorithm_selection',function(){
			$(".discipline_list").show(200);
			$("#algorithm_placeholder").hide(200);
			$("#submit_test_session").hide(200);
		});

		$(document).on('click','.select_algorithm_button',function(){
			$(".discipline_list").hide(200);
			$("#submit_test_session").show(200);
		});

		//функция вызывается при нажатии кнопки СОХРАНИТЬ СЕАНС ТЕСТИРОВАНИЯ
		$(document).on('click','#submit_test_session',function(){
			//если выбран режим генерации
			if ($("input[type=radio][name=input_type]:checked").val() == "generate"){
				//собираем дату
				var date = "";
				date = $("#test_date").val();

				//собираем время тестирования
				var test_time;
				time = $("#test_time").val();

				//собираем группу
				var group;
				group = $("#group_select").val();

				//собираем способ оценивания
				var formula;
				formula = $("#formula_select").val();

				//собираем айди алгоритма
				var algorithm = $(".algorithm_form").prop("id").substring(19);



				var data = {
					"input_type": "generate",
					"date": date,
					"time": time,
					"group": group,
					"formula": formula,
					"algorithm": algorithm
				};

				$.ajax({
			        "url": "/test_sessions/appoint_test_session", 
			        "data": data,
			        "success": function () {
			            alert("Сеанс тестирования сохранён");
			        },
			        "type": 'post'
			    });


			}
			//если выбран режим ручного ввода
			if ($("input[type=radio][name=input_type]:checked").val() == "manual"){
				//собираем все числа в хеш
				var number_variables = [];
				$(".number_type").each(function(){
					//$(this).data("variable-id")
					//$(this).find(".number_cell").val()
					var temp_number = {};
					temp_number.id = $(this).data("variable-id");
					temp_number.value = $(this).find(".number_cell").val();
					number_variables.push(temp_number);
				});

				//собираем все строки
				var string_variables = [];
				$(".string_type").each(function(){
					var temp_string = {};
					temp_string.id = $(this).data("variable-id");
					temp_string.value = $(this).find(".string_cell").val();
					string_variables.push(temp_string);
				});

				//собираем все вектора
				var vector_variables = [];
				$(".vector_type").each(function(){
					var temp_vector = {};
					temp_vector.id = $(this).data("variable-id");
					temp_vector.value = "[";
					//это вариант, когда мы пересылаем не строки, а прям массив, я от него отказался
					/*temp_vector.values = [];
					var length = $(this).data("variable-max")
					$(this).find(".vector_cell").each(function(){
						temp_vector.values.push($(this).val());
					});*/

					//вариант, когда пересылаем строку
					$(this).find(".vector_cell").each(function(){
						temp_vector.value += $(this).val() +",";
					});
					temp_vector.value = temp_vector.value.slice(0, -1);
					temp_vector.value += "]";
					vector_variables.push(temp_vector);
				});

				//собираем все матрицы
				var matrix_variables = [];
				$(".matrix_type").each(function(){
					var temp_matrix = {};
					temp_matrix.id = $(this).data("variable-id");
					temp_matrix.value = "[";
					$(this).find(".matrix_row").each(function(){
						temp_matrix.value += "[";
						$(this).find(".matrix_cell").each(function(){
							temp_matrix.value += $(this).val() +",";
						});
						temp_matrix.value = temp_matrix.value.slice(0, -1);
						temp_matrix.value += "]";
						temp_matrix.value += ",";
					});
					temp_matrix.value = temp_matrix.value.slice(0, -1);
					temp_matrix.value += "]";
					matrix_variables.push(temp_matrix);
				});

				//собираем дату
				var date = "";
				date = $("#test_date").val();

				//собираем время тестирования
				var test_time;
				time = $("#test_time").val();

				//собираем группу
				var group;
				group = $("#group_select").val();

				//собираем способ оценивания
				var formula;
				formula = $("#formula_select").val();

				//собираем айди алгоритма
				var algorithm = $(".algorithm_form").prop("id").substring(19);



				var data = {
					"input_type": "manual",
					"numbers": number_variables,
					"strings": string_variables,
					"vectors": vector_variables,
					"matrixs": matrix_variables,
					"date": date,
					"time": time,
					"group": group,
					"formula": formula,
					"algorithm": algorithm
				};

				$.ajax({
			        "url": "/test_sessions/appoint_test_session", 
			        "data": data,
			        "success": function () {
			            alert("Сеанс тестирования сохранён");
			        },
			        "type": 'post'
			    });
			}
		});
	});
});