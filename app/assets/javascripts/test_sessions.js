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
		$(document).on('click','.algorithm_name',function(){
			if ($(this).data("status") === "closed"){

				$(".algorithm_menu").hide(500);
				$(".algorithm_name").data("status","closed");
				var temp_algorithm_id = this.id.substring(15); //20 = длина step_options_button_

				$(this).data("status","opened");
				$("#algorithm_menu_" + temp_algorithm_id).show(500);
			}
		});

		$("#submit_test_session").click(function(){

		});

		$(document).on('click','.add_new_test', function(){
			name = $("#algorithm_name_"+this.id.substring(13)).html();
			variable = $("input[name=input_type_" + this.id.substring(13) + "]:checked", '#variable_type_form_' + this.id.substring(13)).val(); 
			$(".tests_list").append(addTest(name,variable));
		});

		$(document).on('click','.delete_test',function(){
			$(this).parent().parent().remove();
		});
	});
});