class_name TopPanel
extends Control

const HOVER_SIZE: Vector2 = Vector2.ONE * 1.2
const NORMAL_SIZE: Vector2 = Vector2.ONE
const HIGHLIGHT_COLOR = Color.WHITE * 1.2
const NORMAL_COLOR = Color.WHITE

enum TOPBUTTON {MAP, DECK, SETTINGS}

@export var keys_container: Control = null
@export_group("Name")
@export var user_name: Label = null
@export var character_name: Label = null
@export_group("")

@export_group("HP")
@export var panel_heart: TextureRect = null
@export var health_info: Label = null
@export_group("")


@export_group("Gold")
@export var panel_gold: TextureRect = null
@export var gold_info: Label = null
@export_group("")


@export_group("Potions")
@export var potions: Array[TextureRect] = []
@export_group("")

@export_group("Dungeon Info")
@export var floor_icon: TextureRect = null
@export var floor_num: Label = null
@export var ascension_icon: TextureRect = null
@export var ascension_level: Label = null
@export_group("")

@export_group("PlayTime")
@export var play_time: Label = null
@export_group("")


@export_group("TopRight")
@export var map: TextureRect = null
@export var deck: TextureRect = null
@export var deck_amount: Label = null
@export var setting: TextureRect = null
@export_group("")

var hp_btn: Button = null
var gold_btn: Button = null
var potions_btn: Array[Button] = []
var dungeon_info_btn: Button = null
var play_time_btn: Button = null
var map_btn: Button = null
var deck_btn: Button = null
var setting_btn: Button = null

var display_gold: int = 0
var rotate_timer: float = 0.0
var map_angle: float = 0.0
var deck_angle: float = 0.0
var setting_angle: float = 0.0

var dungeon_main: DungeonMainScreen = null
func _ready() -> void:
	initialize_style()
	initialize_buttons()

	await get_tree().process_frame
	panel_heart.pivot_offset = panel_heart.size / 2.0
	panel_gold.pivot_offset = panel_gold.size / 2.0
	for potion in potions:
		potion.pivot_offset = potion.size / 2.0
	map.pivot_offset = map.size / 2.0
	deck.pivot_offset = deck.size / 2.0
	setting.pivot_offset = setting.size / 2.0

func _process(delta: float) -> void:
	if not dungeon_main:
		return
	update_hp()
	update_gold()
	update_floor()
	update_play_time()
	update_buttons(delta)
	update_hover()

func update_buttons(delta: float) -> void:
	# map
	if dungeon_main.cur_screen == DungeonMainScreen.ScreenType.MAP:
		rotate_timer += delta * 4.0
		map_angle = MathHelper.lerp_snap(map_angle, sin(rotate_timer) * 15.0, delta * 12.0)
	elif map_btn.is_hovered():
		map_angle = MathHelper.lerp_snap(map_angle, 10.0, delta * 12.0)
	else:
		map_angle = MathHelper.lerp_snap(map_angle, -5, delta * 12.0)

	map.rotation_degrees = map_angle

	# deck
	if dungeon_main.cur_screen == DungeonMainScreen.ScreenType.MASTER_DECK_VIEW:
		rotate_timer += delta * 4.0
		deck_angle = MathHelper.lerp_snap(deck_angle, sin(rotate_timer) * 15.0, delta * 12.0)
	elif deck_btn.is_hovered():
		deck_angle = MathHelper.lerp_snap(deck_angle, 15.0, delta * 12.0)
	else:
		deck_angle = MathHelper.lerp_snap(deck_angle, 0, delta * 12.0)

	deck.rotation_degrees = deck_angle

	# setting
	if dungeon_main.cur_screen == DungeonMainScreen.ScreenType.SETTINGS:
		setting_angle += delta * 300.0
		if setting_angle > 360.0:
			setting_angle -= 360.0
	elif setting_btn.is_hovered():
		setting_angle = MathHelper.lerp_snap(setting_angle, -90, delta * 12.0)
	else:
		setting_angle = MathHelper.lerp_snap(setting_angle, 0, delta * 12.0)
	
	setting.rotation_degrees = setting_angle

func update_hp() -> void:
	health_info.text = str(dungeon_main.player.current_health) + "/" + str(dungeon_main.player.max_health)

func update_gold() -> void:
	if display_gold == dungeon_main.player.gold:
		return
	
	if display_gold > dungeon_main.player.gold:
		if display_gold - dungeon_main.player.gold > 99:
			display_gold -= 10
		elif display_gold - dungeon_main.player.gold > 9:
			display_gold -= 3
		else:
			display_gold -= 1
	elif display_gold < dungeon_main.player.gold:
		if dungeon_main.player.gold - display_gold > 99:
			display_gold += 10
		elif dungeon_main.player.gold - display_gold > 9:
			display_gold += 3
		else:
			display_gold += 1

	gold_info.text = str(display_gold)
	if display_gold > dungeon_main.player.gold:
		gold_info.modulate = ThemeHelper.RED_TEXT_COLOR
	elif display_gold < dungeon_main.player.gold:
		gold_info.modulate = ThemeHelper.RED_TEXT_COLOR
	else:
		gold_info.modulate = ThemeHelper.GOLD_COLOR

func update_floor() -> void:
	if dungeon_main.floor_num >= 1:
		floor_icon.show()
		floor_num.show()
		floor_num.text = str(dungeon_main.floor_num)
	else:
		floor_icon.hide()
		floor_num.hide()
	
	
func update_play_time() -> void:
	pass
	# convert dungeon_main.play_time to "MM:SS" format
	play_time.text = to_hms_format(dungeon_main.play_time)

func update_hover() -> void:
	if hp_btn.is_hovered():
		panel_heart.scale = HOVER_SIZE
	else:
		panel_heart.scale = NORMAL_SIZE
	
	if gold_btn.is_hovered():
		panel_gold.scale = HOVER_SIZE
	else:
		panel_gold.scale = NORMAL_SIZE
	
	for i in range(potions.size()):
		if potions_btn[i].is_hovered():
			potions[i].scale = HOVER_SIZE
		else:
			potions[i].scale = NORMAL_SIZE
	
	if map_btn.is_hovered():
		map.modulate = HIGHLIGHT_COLOR
	else:
		map.modulate = NORMAL_COLOR
	
	if deck_btn.is_hovered():
		deck.self_modulate = HIGHLIGHT_COLOR
	else:
		deck.self_modulate = NORMAL_COLOR
	
	if setting_btn.is_hovered():
		setting.modulate = HIGHLIGHT_COLOR
	else:
		setting.modulate = NORMAL_COLOR

func on_map_open() -> void:
	$PlayTime.show()

func on_map_close() -> void:
	$PlayTime.hide()

func load_data(dungeon_main_screen: DungeonMainScreen, player: AbstractPlayer) -> void:
	dungeon_main = dungeon_main_screen
	var character_info: CharacterInfo = player.get_character_info()
	character_name.text = character_info.name
	refresh_master_deck_amount()
	if dungeon_main.is_ascension_mode:
		keys_container.show()
		ascension_icon.show()
		ascension_level.show()
		ascension_level.text = str(dungeon_main.ascension_level)
	else:
		keys_container.hide()
		ascension_icon.hide()
		ascension_level.hide()

func refresh_master_deck_amount() -> void:
	deck_amount.text = str(dungeon_main.player.master_decks.group.size())

func initialize_buttons() -> void:
	hp_btn = ButtonHelper.create_fit_button($HP, $Buttons)
	gold_btn = ButtonHelper.create_fit_button($Gold, $Buttons)
	potions_btn.clear()
	for i in range(potions.size()):
		potions_btn.append(ButtonHelper.create_fit_button(potions[i]))
	dungeon_info_btn = ButtonHelper.create_fit_button($DungeonInfo, $Buttons)
	play_time_btn = ButtonHelper.create_fit_button($PlayTime, $Buttons)
	map_btn = ButtonHelper.create_fit_button($TopRightIcons/Map)
	deck_btn = ButtonHelper.create_fit_button($TopRightIcons/Deck)
	setting_btn = ButtonHelper.create_fit_button($TopRightIcons/Settings)

	map_btn.mouse_entered.connect(_on_button_mouse_entered)
	deck_btn.mouse_entered.connect(_on_button_mouse_entered)
	setting_btn.mouse_entered.connect(_on_button_mouse_entered)
	
	map_btn.pressed.connect(_on_button_clicked.bind(TOPBUTTON.MAP))
	deck_btn.pressed.connect(_on_button_clicked.bind(TOPBUTTON.DECK))
	setting_btn.pressed.connect(_on_button_clicked.bind(TOPBUTTON.SETTINGS))

func initialize_style() -> void:
	# name
	ThemeHelper.apply_label_font_style_with_settings(user_name, ThemeHelper.panel_name_label_settings, Color.WHITE)
	ThemeHelper.apply_label_font_style_with_settings(character_name, ThemeHelper.tip_body_label_settings, Color.LIGHT_GRAY)

	# hp
	ThemeHelper.apply_label_font_style_with_settings(health_info, ThemeHelper.top_panel_info_label_settings, Color.SALMON)
	# gold
	ThemeHelper.apply_label_font_style_with_settings(gold_info, ThemeHelper.top_panel_info_label_settings, Color.WHITE)

	# dungeon info
	ThemeHelper.apply_label_font_style_with_settings(floor_num, ThemeHelper.top_panel_info_label_settings, ThemeHelper.CREAM_COLOR)
	ThemeHelper.apply_label_font_style_with_settings(ascension_level, ThemeHelper.top_panel_info_label_settings, ThemeHelper.RED_TEXT_COLOR)

	# play time
	ThemeHelper.apply_label_font_style_with_settings(play_time, ThemeHelper.tip_body_label_settings, ThemeHelper.GOLD_COLOR)

	ThemeHelper.apply_label_font_style_with_settings(deck_amount, ThemeHelper.top_panel_amount_label_settings, Color.WHITE)
	

func _on_button_mouse_entered() -> void:
	CardGame.sound.single_play("UI_HOVER")

func _on_button_clicked(btn_type: TOPBUTTON) -> void:
	# CardGame.sound.single_play("UI_CLICK_1")
	if btn_type == TOPBUTTON.MAP:
		dungeon_main.on_top_panel_map_button_click()
	elif btn_type == TOPBUTTON.DECK:
		dungeon_main.on_top_panel_deck_button_click()
		pass
	elif btn_type == TOPBUTTON.SETTINGS:
		pass
		

func to_hms_format(time_in_seconds: float) -> String:
	var hours: int = int(time_in_seconds / 3600)
	var minutes: int = int(time_in_seconds / 60)
	var seconds: int = int(time_in_seconds) % 60
	if hours > 0:
		return str(hours).pad_zeros(2) + ":" + str(minutes).pad_zeros(2) + ":" + str(seconds).pad_zeros(2)
	else:
		return str(minutes).pad_zeros(2) + ":" + str(seconds).pad_zeros(2)
