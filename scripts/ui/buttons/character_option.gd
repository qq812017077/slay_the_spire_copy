class_name CharacterOption
extends Button

const BLACK_OUTLINE_COLOR = Color(0, 0, 0, 0.5)
const UNSELECTED_COLOR = Color(0.5, 0.5, 0.5, 1)
const SELECTED_COLOR = Color.WHITE


static var ui_string: UIString = null
static var TEXT: Array = []

@export var character_info_container: CharacterInfoContainer = null
@export var player_type: AbstractPlayer.PlayerType
@export var highlight: Sprite2D
@export var player_icon: Sprite2D
var relic: AbstractRelic

# character info
var character_info :CharacterInfo = null
var character_name: String = ""
var portrait_img: Texture2D

var glow_color: Color = Color(1.0, 0.8, 0.2, 0.0);
var timer: float = 0


var offsetX: float = 0

static func initialize() -> void:
	ui_string = CardGame.languagePack.get_ui_string("CharacterOption")
	TEXT = ui_string.TEXT

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	toggle_mode = true
	ThemeHelper.clean_button_style(self)
	# toggled.connect(_on_toggle_changed)
	character_info = CharacterManager.get_character(player_type).get_character_info()
	
	relic = character_info.relics[0]
	match player_type:
		AbstractPlayer.PlayerType.IRONCLAD:
			character_name = CharacterSelectScreen.TEXT[2]
			player_icon.texture = ImageMaster.CHARACTER_SELECT_IRONCLAD
			portrait_img = ImageMaster.CHARACTER_SELECT_BG_IRONCLAD
		AbstractPlayer.PlayerType.THE_SILENT:
			character_name = CharacterSelectScreen.TEXT[3]
			player_icon.texture = ImageMaster.CHARACTER_SELECT_SILENT
			portrait_img = ImageMaster.CHARACTER_SELECT_BG_SILENT
		AbstractPlayer.PlayerType.DEFECT:
			character_name = CharacterSelectScreen.TEXT[4]
			player_icon.texture = ImageMaster.CHARACTER_SELECT_DEFECT
			portrait_img = ImageMaster.CHARACTER_SELECT_BG_DEFECT
		AbstractPlayer.PlayerType.WATCHER:
			character_name = CharacterSelectScreen.TEXT[14]
			player_icon.texture = ImageMaster.CHARACTER_SELECT_WATCHER
			portrait_img = ImageMaster.CHARACTER_SELECT_BG_WATCHER

	character_info_container.apply_style()
	character_info_container.character_name.text = character_info.name
	character_info_container.hp_info.text = CharacterOption.TEXT[4] + character_info.hp
	character_info_container.coin_info.text = CharacterOption.TEXT[5] + str(character_info.gold)
	character_info_container.description.text = character_info.flavorText
	character_info_container.relic_outlint_icon.texture = relic.outline_img
	character_info_container.relic_icon.texture = relic.img
	character_info_container.relic_name.text = relic.name
	character_info_container.relic_description.text = relic.description
	
	character_info_container.description.generate_commands()
	character_info_container.relic_description.generate_commands()
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var alpha = character_info_container.modulate.a
	if button_pressed:
		timer += delta
		# print(timer)
		glow_color.a = 0.25 + (cos(timer * 4) + 1.25) / 3.5
		highlight.self_modulate = glow_color
		offsetX = MathHelper.lerp_snap(offsetX, 0, delta * 9)
		alpha = MathHelper.lerp_snap(alpha, 1, delta * 9)
	else:
		highlight.self_modulate = BLACK_OUTLINE_COLOR
		offsetX = MathHelper.lerp_snap(offsetX, -800, delta * 9)
		alpha = MathHelper.lerp_snap(alpha, 0, delta * 9)
	
	if is_hovered() or button_pressed:
		modulate = SELECTED_COLOR
	else:
		modulate = UNSELECTED_COLOR

	character_info_container.position.x = offsetX
	character_info_container.modulate.a = alpha

func play_effect() -> void:
	match player_type:
		AbstractPlayer.PlayerType.IRONCLAD:
			CardGame.sound.single_play("ATTACK_HEAVY", randf_range(-0.2, 0.2))
			CardGame.screen_shake.shake(ScreenShake.ShakeIntensity.MED, ScreenShake.ShakeDur.SHORT, true)
		AbstractPlayer.PlayerType.THE_SILENT:
			CardGame.sound.single_play("ATTACK_DAGGER_2", randf_range(-0.2, 0.2))
			CardGame.screen_shake.shake(ScreenShake.ShakeIntensity.MED, ScreenShake.ShakeDur.SHORT, false)
		AbstractPlayer.PlayerType.DEFECT:
			CardGame.sound.single_play("ATTACK_MAGIC_BEAM_SHORT", randf_range(-0.2, 0.2))
			CardGame.screen_shake.shake(ScreenShake.ShakeIntensity.MED, ScreenShake.ShakeDur.SHORT, false)
		AbstractPlayer.PlayerType.WATCHER:
			CardGame.sound.single_play("SELECT_WATCHER", randf_range(-0.2, 0.2))
			CardGame.screen_shake.shake(ScreenShake.ShakeIntensity.MED, ScreenShake.ShakeDur.SHORT, false)
