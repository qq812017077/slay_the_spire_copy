class_name RewardItemWidget
extends Control

static var ui_string: UIString = null
static var TEXT: Array = []

static func initialize() -> void:
	ui_string = CardGame.languagePack.get_ui_string("RewardItem")
	TEXT = ui_string.TEXT

const REWARD_ITEM_HOVER_COLOR = Color(0.4, 0.6, 0.6, 1.0)
const REWARD_ITEM_NORMAL_COLOR = Color(0.5, 0.6, 0.6, 0.8)
const REWARD_ITEM_FLASH_COLOR = Color(0.6, 1.0, 1.0, 0)
@export var reward_panel: Sprite2D = null
@export var reward_icon: TextureRect = null
@export var reward_description: Label = null

var btn: Button = null
var color: Color = Color.WHITE

# glow
var glow_timer: float = 1.1
var reward_panel_glow: Sprite2D = null
var reward_panel_flash: Sprite2D = null

# flash
var flash_timer: float = 0.0

var reward_item: RewardItem = null

func _ready() -> void:
	btn = ButtonHelper.create_fit_button(self)

	ThemeHelper.apply_label_font_style_with_settings(reward_description, ThemeHelper.card_desc_font_N_label_settigns, Color.WHITE)

	reward_panel_glow = reward_panel.duplicate()
	reward_panel_flash = reward_panel.duplicate()
	reward_panel.add_child(reward_panel_glow)
	reward_panel.add_child(reward_panel_flash)

	reward_panel_glow.position = Vector2(0, 0)
	reward_panel_glow.material = MaterialLibrary.add_material
	reward_panel_glow.modulate = Color.WHITE

	reward_panel_flash.position = Vector2(0, 0)
	reward_panel_flash.material = MaterialLibrary.add_material
	reward_panel_flash.modulate = REWARD_ITEM_FLASH_COLOR
	reward_panel_flash.scale = Vector2(1.03, 1.15)


func _process(delta: float) -> void:
	var text_color: Color = Color.WHITE
	if btn.is_hovered():
		reward_panel.modulate = REWARD_ITEM_HOVER_COLOR
		reward_panel_glow.modulate.a = 0
		glow_timer = 0.1
		text_color = ThemeHelper.GOLD_COLOR
	else:
		reward_panel.modulate = REWARD_ITEM_NORMAL_COLOR
		update_glow_effect(delta)
		text_color = ThemeHelper.CREAM_COLOR

	reward_description.modulate = text_color
	update_flash_effect(delta)

func update_glow_effect(delta: float) -> void:
	glow_timer -= delta
	if glow_timer < 0:
		glow_timer = 1.1
		reward_panel_glow.scale = Vector2.ONE
	reward_panel_glow.scale += delta * Vector2.ONE / 20.0
	reward_panel_glow.modulate.a = CardGame.interpolation.apply_fade(0.0, 1.0, glow_timer / 1.1) / 12.0

func update_flash_effect(delta: float) -> void:
	if flash_timer > 0:
		flash_timer -= delta
		flash_timer = max(flash_timer, 0.0)

		reward_panel_flash.modulate.a = flash_timer * 1.5
func flash() -> void:
	flash_timer = 0.5

func load_reward_item(item: RewardItem) -> void:
	self.reward_item = item

	match reward_item.type:
		RewardItem.RewardType.CARD:
			reward_icon.texture = ImageMaster.reward_card_boss if CardGame.dungeon_main_screen.dungeon.is_boss_room() else ImageMaster.reward_card_normal
			reward_description.text = TEXT[2]
		RewardItem.RewardType.GOLD:
			reward_icon.texture = ImageMaster.UI_GOLD
			reward_description.text = str(reward_item.gold_amount) + TEXT[1]
		RewardItem.RewardType.RELIC:
			reward_description.text = reward_item.relic.name
		RewardItem.RewardType.POTION:
			reward_description.text = reward_item.potion.name
		RewardItem.RewardType.STOLEN_GOLD:
			reward_icon.texture = ImageMaster.UI_GOLD
			reward_description.text = str(reward_item.gold_amount) + TEXT[0]
		RewardItem.RewardType.EMERALD_KEY:
			reward_description.text = TEXT[5]
		RewardItem.RewardType.SAPPHIRE_KEY:
			reward_description.text = TEXT[6]

func claim() -> void:
	match reward_item.type:
		RewardItem.RewardType.CARD:
			if CardGame.dungeon_main_screen.cur_screen == DungeonMainScreen.ScreenType.COMBAT_REWARD:
				# CardGame.dungeon_main_screen.card_reward_screen
				CardGame.dungeon_main_screen.open_card_reward_screen(self, TEXT[4])
		RewardItem.RewardType.GOLD:
			CardGame.sound.single_play("GOLD_GAIN")
			CardGame.dungeon_main_screen.player.gain_gold(reward_item.get_gold())
		RewardItem.RewardType.RELIC:
			pass
		RewardItem.RewardType.POTION:
			pass
		RewardItem.RewardType.STOLEN_GOLD:
			pass
		RewardItem.RewardType.EMERALD_KEY:
			pass
		RewardItem.RewardType.SAPPHIRE_KEY:
			pass
