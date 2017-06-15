
function addTest(id){
	
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
	});
});