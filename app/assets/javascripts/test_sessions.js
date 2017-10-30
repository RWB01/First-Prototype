function renewAlgorithmLists() {
	var algorithms_list = [];

	$(".algorithm_checkbox").each(function(){
		if (this.checked) {
			var temp_algorithm = {};
			temp_algorithm.id = this.value;
			temp_algorithm.title = gon.algorithms.find(x => x.id == this.value).title;
			algorithms_list.push(temp_algorithm);
		}
	})

	$(".algorithm_select").each(function(){
		list = this;
		algorithms_list.forEach(function(element,index,array){
			//alert(element.id+"  "+element.title);
			//list.append("<option value=\"" + element.id + "\">" + element.title + "</option>");
			list.append(new Option(element.title, element.id));
			//list.append("Дарова бандиты");
		})
	})

};

//должно вызываться при нажатии на тему и при нажатии на алгоритм!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
function addAlgorithmToLists(algorithm_id) {
	var title = gon.algorithms.find(x => x.id == algorithm_id).title;
	$(".algorithm_select").each(function(){
		list.append(new Option(title, algorithm_id));
	})
}

function deleteAlgorithmFromLists(algorithm_id) {

}

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
			$("#notification_unselected").hide(100);
			$("#notification_selected").show(100);
		});
		
		//обработка чекбокса выбора темы
		$('.theme_checkbox').change(function() {
	        if(this.checked) {
	            $(this).parent().parent().find(".theme_algorithms_wrapper").show(100);
	            //тут мы выставляем все галочки в алгоритмах темы
	            $(this).parent().parent().find(".algorithm_checkbox:enabled").prop('checked', true);
	            //тут при добавлении темы должны добавиться все её алгоритмы в поле выбора в карточках студентов
	        }      
	        if(!this.checked) {
	            $(this).parent().parent().find(".theme_algorithms_wrapper").hide(100);
	            //тут мы убираем все галочки в алгоритмах темы
	            $(this).parent().parent().find(".algorithm_checkbox").prop('checked', false);
	            //тут при удалении темы должны исчезнуть все её алгоритмы в поле выбора в карточках студентов
	        }    
	    });

	    //обработка чекбокса выбора алгоритма
		$('.algorithm_checkbox').change(function() {
			//если мы включаем чекбокс, то алгоритм появляется в поле выбора в карточках студентов


			//если мы выключаем чекбокс, то алгоритм исчезает из соответствующего поля выбора в карточках студентов
			//а так же, если алгоритм был у кого-то выбран, то исчезают его поля ввода и карточка обнуляется
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
		});


	});
});