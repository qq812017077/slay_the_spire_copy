class_name MasterDeckSortHeader
extends SortHeader


@export var obtaing_order_button: Button = null
@export var type_button: Button = null
@export var cost_button: Button = null


func collect_buttons() -> Array[Button]:
	return [obtaing_order_button, type_button, cost_button]

func collect_sort_types() -> Array[SortType]:
	return [SortType.ObtaingOrder, SortType.Type, SortType.Cost]

func collect_btn_names() -> Array[String]:
	return [TEXT[5], TEXT[1], TEXT[3]]
