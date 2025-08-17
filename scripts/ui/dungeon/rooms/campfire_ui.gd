class_name CampfireUI
extends Control


static var ui_string: UIString
static var TEXT: Array

static var rest_ui_string: UIString
static var REST_TEXT: Array

static var smith_ui_string: UIString
static var SMITH_TEXT: Array

static var toke_ui_string: UIString
static var TOKE_TEXT: Array

static var recall_ui_string: UIString
static var RECALL_TEXT: Array

static var lift_ui_string: UIString
static var LIFT_TEXT: Array

static var dig_ui_string: UIString
static var DIG_TEXT: Array


signal hide_campfire_ui

@export var campfire_bubble_effect_prefab: PackedScene = null
@export var campfire_burning_effect: CampfireBurningEffect = null
@export var campfire_bubble_effect: CampfireBubbleEffect = null
@export var option_prefab: PackedScene = null
@export var option_desc: Label = null

@export_group("Sleep")
@export var campfire_sleep_over_effect_prefab: PackedScene = null
var campfire_sleep_over_effect: CampfireSleepOverEffect = null
@export_group("")

var options: Array[CampfireOption] = []
var hovered_option: CampfireOption = null
var display_desc: bool = false
var is_effect_paused: bool = false

@onready var options_container: Control = $Options
func _ready() -> void:
	if ui_string == null:
		ui_string = CardGame.languagePack.get_ui_string("CampfireUI")
		TEXT = ui_string.TEXT

		rest_ui_string = CardGame.languagePack.get_ui_string("Rest Option")
		REST_TEXT = rest_ui_string.TEXT

		smith_ui_string = CardGame.languagePack.get_ui_string("Smith Option")
		SMITH_TEXT = smith_ui_string.TEXT
		
		toke_ui_string = CardGame.languagePack.get_ui_string("Toke Option")
		TOKE_TEXT = toke_ui_string.TEXT

		recall_ui_string = CardGame.languagePack.get_ui_string("Recall Option")
		RECALL_TEXT = recall_ui_string.TEXT

		lift_ui_string = CardGame.languagePack.get_ui_string("Lift Option")
		LIFT_TEXT = lift_ui_string.TEXT

		dig_ui_string = CardGame.languagePack.get_ui_string("Dig Option")
		DIG_TEXT = dig_ui_string.TEXT
	options_container.position.x = (1920 - options_container.size.x) / 2

	get_parent().move_child.call_deferred(self, -1)

	ThemeHelper.apply_label_font_style_with_settings(option_desc, ThemeHelper.top_panel_info_label_settings, ThemeHelper.CREAM_COLOR)
	# initialize_buttons()

	# adjust_bubble_effect()
	campfire_bubble_effect.queue_free()

func _process(delta: float) -> void:
	if not visible:
		return
	update_option_desc(delta)
	
	if CardGame.dungeon_main_screen.cur_screen != DungeonMainScreen.ScreenType.ROOM:
		if not is_effect_paused:
			is_effect_paused = true
			campfire_burning_effect.pause()
			campfire_bubble_effect.pause()
	else:
		if is_effect_paused:
			is_effect_paused = false
			campfire_burning_effect.resume()
			campfire_bubble_effect.resume()

func update_option_desc(delta: float) -> void:
	var hovered_opt = null
	for option in options:
		if option.is_hovered:
			hovered_opt = option
			break
	if hovered_opt != hovered_option:
		hovered_option = hovered_opt
		if hovered_option:
			display_desc = true
			option_desc.text = get_description(hovered_option)
			var str_size: Vector2 = ThemeHelper.top_panel_info_label_settings.font.get_string_size(option_desc.text, HORIZONTAL_ALIGNMENT_LEFT, -1, ThemeHelper.top_panel_info_label_settings.font_size)
			option_desc.position.x = (1920 - str_size.x) / 2
		else:
			display_desc = false
	
	var target_alpha: float = 1.0 if display_desc else 0.0
	option_desc.modulate.a = MathHelper.lerp_snap(option_desc.modulate.a, target_alpha, delta * 5)


func initialize_buttons() -> void:
	for child: Node in options_container.get_children():
		child.queue_free()
	options.clear()
	# print("REST_TEXT[1]: ", REST_TEXT[1])
	add_button(CampfireOption.Type.REST, REST_TEXT[0], REST_TEXT[1], ImageMaster.campfire_rest_button)
	add_button(CampfireOption.Type.SMITH, SMITH_TEXT[0], SMITH_TEXT[1], ImageMaster.campfire_smith_button)
	if CardGame.dungeon_main_screen.is_ascension_mode:
		add_button(CampfireOption.Type.RECALL, RECALL_TEXT[0], RECALL_TEXT[1], ImageMaster.campfire_recall_button)

func open():
	visible = true
	option_desc.modulate.a = 0.0
	adjust_bubble_effect()
	campfire_burning_effect.play()
	campfire_bubble_effect.play()
	is_effect_paused = false

func close():
	visible = false
	option_desc.modulate.a = 0.0
	campfire_burning_effect.stop()

func adjust_bubble_effect() -> void:
	if not campfire_bubble_effect:
		campfire_bubble_effect = campfire_bubble_effect_prefab.instantiate()
		add_child(campfire_bubble_effect)
		move_child(campfire_bubble_effect, 1)

	var opts_rect: Rect2 = options_container.get_rect()
	var center_x: float = opts_rect.position.x + (opts_rect.size.x / 2)
	var center_y: float = 0
	var size_x: float = opts_rect.size.x
	var size_y: float = 0
	var amount: int = 10
	if options.size() < 3:
		center_y = opts_rect.position.y + options[0].size.y / 2
		size_y = options[0].size.y
		amount = 15
	elif options.size() < 5:
		center_y = opts_rect.position.y + options[0].size.y
		size_y = options[0].size.y * 2
		amount = 20
	else:
		center_y = opts_rect.position.y + (options[0].size.y * 1.5)
		size_y = options[0].size.y * 3
		amount = 30

	campfire_bubble_effect.set_particle_position(Vector2(center_x, center_y), Vector2(size_x, size_y), amount)
	
func add_button(type: CampfireOption.Type, label: String, desc: String, img: Texture2D) -> void:
	var campfire_button: CampfireOption = option_prefab.instantiate()
	options_container.add_child(campfire_button)
	campfire_button.type = type
	campfire_button.option_name.text = label
	campfire_button.desc = desc
	campfire_button.initialize(img)
	campfire_button.btn.pressed.connect(_on_option_click.bind(campfire_button))
	options.append(campfire_button)

func get_description(option: CampfireOption) -> String:
	var healAmt: int = int(CardGame.dungeon_main_screen.player.max_health * 0.3)
	if CampfireOption.Type.REST == option.type:
		return REST_TEXT[3] + str(healAmt) + ")" + LocalizedString.PERIOD
	
	return option.desc

func _on_option_click(option: CampfireOption) -> void:
	# print("Option clicked: ", CampfireOption.Type.find_key(option.type))
	if option.type == CampfireOption.Type.REST:
		# black
		# play effect
		# sleep_
		var sleep_effect = CampfireSleepEffect.new(CardGame.dungeon_main_screen.dungeon.cur_room_node.room)
		# add_child(sleep_effect)
		CardGame.dungeon_main_screen.add_game_effect(sleep_effect)
		
		var sleep_over_effect: CampfireSleepOverEffect = campfire_sleep_over_effect_prefab.instantiate()
		# add_child(sleep_over_effect)
		CardGame.dungeon_main_screen.add_particle_effect(sleep_over_effect)
		var timer: SceneTreeTimer = get_tree().create_timer(0.5)
		timer.timeout.connect(_on_campfire_end)
	elif option.type == CampfireOption.Type.SMITH:
		CardGame.black_mask.fade_in(0.3, _display_smith_screen)
	elif option.type == CampfireOption.Type.TOKE:
		pass
	elif option.type == CampfireOption.Type.TRAIN:
		pass
	elif option.type == CampfireOption.Type.DIG:
		pass
	elif option.type == CampfireOption.Type.RECALL:
		pass

func _on_campfire_end(delay_time: float = 2.0) -> void:
	visible = false
	campfire_bubble_effect.queue_free()
	hide_campfire_ui.emit(delay_time)

func _display_smith_screen() -> void:
	CardGame.black_mask.fade_out(0.3)
	CardGame.dungeon_main_screen.open_screen(DungeonMainScreen.ScreenType.SMITH_DECK_VIEW)
	# var timer: SceneTreeTimer = get_tree().create_timer(0.5)
	# timer.timeout.connect(_on_campfire_end.bind(3.0))
