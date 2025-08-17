class_name CardLibSortHeader
extends SortHeader


@export var rarity_button: Button = null
@export var type_button: Button = null
@export var cost_button: Button = null



func collect_buttons() -> Array[Button]:
	return [rarity_button, type_button, cost_button]

func collect_sort_types() -> Array[SortType]:
	return [SortType.Rarity, SortType.Type, SortType.Cost]

func collect_btn_names() -> Array[String]:
	return [TEXT[0], TEXT[1], TEXT[3]]