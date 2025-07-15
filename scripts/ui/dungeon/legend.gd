class_name Legend
extends Control

const OFFSET_X = 10
const OFFSET_Y = 10
static var ui_string: UIString = null
static var TEXT: Array = []

static func initialize() -> void:
	ui_string = CardGame.languagePack.get_ui_string("Legend")
	TEXT = ui_string.TEXT

@export var legend_item_prefab: PackedScene = null
@export var banner: Label = null
@export var legend_item_container: VBoxContainer

var legend_items: Array[LegendItem] = []

var on_item_mouse_entered: Callable
var on_item_mouse_exited: Callable
func _ready() -> void:
	ThemeHelper.apply_label_font_style_with(banner, {
		"font": ThemeHelper.get_bold_font(),
		"font_size": 38,
		"font_color": ThemeHelper.AVAILABLE_COLOR,
		"font_outline_color": Color(0.35, 0.35, 0.35, 1),
		"outline_size": 0,
		"font_shadow_color": Color(0.0, 0.0, 0.0, 0.11),
		"shadow_offset_x": 3,
		"shadow_offset_y": 3,
		})
	
	add_legend_item(AbstractRoom.RoomType.EVENT, ImageMaster.map_node_event, TEXT[0], TEXT[1], TEXT[2])
	add_legend_item(AbstractRoom.RoomType.SHOP, ImageMaster.map_node_merchant, TEXT[3], TEXT[4], TEXT[5])
	add_legend_item(AbstractRoom.RoomType.TREASURE, ImageMaster.map_node_treasure, TEXT[6], TEXT[7], TEXT[8])
	add_legend_item(AbstractRoom.RoomType.REST, ImageMaster.map_node_rest, TEXT[9], TEXT[10], TEXT[11])
	add_legend_item(AbstractRoom.RoomType.MONSTER, ImageMaster.map_node_enemy, TEXT[12], TEXT[13], TEXT[14])
	add_legend_item(AbstractRoom.RoomType.ELITE, ImageMaster.map_node_elite, TEXT[15], TEXT[16], TEXT[17])

func _process(_delta: float) -> void:
	for item: LegendItem in legend_items:
		if item.is_hover():
			CardGame.tip.render_generic_tip($TipCursor.global_position, item.tip_header, item.tip_body)

func add_legend_item(room_type: AbstractRoom.RoomType, tex: Texture2D, label: String, tip_header: String, tip_body: String):
	var item: LegendItem = legend_item_prefab.instantiate()
	legend_item_container.add_child(item)
	item.name = label
	item.type = room_type
	item.legend_icon.texture = tex
	item.legend_name.text = label
	item.tip_header = tip_header
	item.tip_body = tip_body
	item.mouse_entered.connect(on_mouse_entered_item.bind(item))
	item.mouse_exited.connect(on_mouse_exited_item.bind(item))

	legend_items.append(item)

func on_mouse_entered_item(item: LegendItem) -> void:
	if on_item_mouse_entered.is_valid():
		on_item_mouse_entered.call(item)

func on_mouse_exited_item(item: LegendItem) -> void:
	if on_item_mouse_exited.is_valid():
		on_item_mouse_exited.call(item)
