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
		$(document).on('click','.discipline_name',function(){
			if ($(this).data("status") === "closed"){
				$(".theme_list").hide(500);
				$(".algorithm_list").hide(500);
				$(".discipline_name").data("status","closed");
				$(this).parent().find(".theme_list").show(500);
				$(this).data("status","opened");
			} else {
				$(this).parent().find(".theme_list").hide(500);
				$(this).data("status","closed");
			}
		});

		$(document).on('click','.theme_name',function(){
			if ($(this).data("status") === "closed"){
				$(".algorithm_list").hide(500);
				$(".theme_name").data("status","closed");
				$(this).parent().find(".algorithm_list").show(500);
				$(this).data("status","opened");
			} else {
				$(this).parent().find(".algorithm_list").hide(500);
				$(this).data("status","closed");
			}
		});

		$("#submit_test_session").click(function(){

		});

		//$(document).on('click','.add_new_test', function(){
		//	name = $("#algorithm_name_"+this.id.substring(13)).html();
		//	variable = $("input[name=input_type_" + this.id.substring(13) + "]:checked", '#variable_type_form_' + this.id.substring(13)).val(); 
		//	$(".tests_list").append(addTest(name,variable));
		//});

		//$(document).on('click','.delete_test',function(){
		//	$(this).parent().parent().remove();
		//});
	});
});