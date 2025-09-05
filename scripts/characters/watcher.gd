class_name Watcher
extends AbstractPlayer

static var character_string: CharacterString = null
static var CHARACTER_NAMES: Array
static var CHARACTER_TEXT: Array

const ID: String = "Watcher"

const WATCHER_IDLE_ANIM = "watcher_idle"
const WATCHER_HIT_ANIM = "watcher_hit"

func _init() -> void:
	if character_string == null:
		character_string = CardGame.languagePack.get_character_string(ID)
		CHARACTER_NAMES = character_string.NAMES
		CHARACTER_TEXT = character_string.TEXT

	super (AbstractPlayer.PlayerType.WATCHER, WATCHER_IDLE_ANIM, WATCHER_HIT_ANIM)
	
	shoulder_img = ImageMaster.watcher_shoulder_img
	shoulder2_img = ImageMaster.watcher_shoulder2_img

func get_character_info() -> CharacterInfo:
	return CharacterInfo.new(
		CHARACTER_NAMES[0],
		CHARACTER_TEXT[0],
		72,
		72,
		0,
		99,
		5,
		self,
		get_starting_relics(),
		get_starting_deck(),
		false
	)

func get_starting_relics() -> Array:
	var result: Array = []
	result.append(RelicLibrary.get_relic("PureWater"))
	return result

func get_starting_deck() -> Array[String]:
	var result: Array[String] = []
	result.append(StrikePurple.ID)
	result.append(StrikePurple.ID)
	result.append(StrikePurple.ID)
	result.append(StrikePurple.ID)
	result.append(StrikePurple.ID)

	result.append(DefendWatcher.ID)
	result.append(DefendWatcher.ID)
	result.append(DefendWatcher.ID)
	result.append(DefendWatcher.ID)
	result.append(DefendWatcher.ID)

	result.append(Eruption.ID)
	result.append(Vigilance.ID)
	return result


func get_card_trail_color() -> Color:
	return Color.PURPLE

func setup_orb(energy_orb_widget: EnergyOrbWidget) -> void:
	energy_orb_widget.update_orb = update_orb_purple
	energy_orb_widget.energy_layer1 = ImageMaster.energy_red_layer1
	energy_orb_widget.energy_layer2 = ImageMaster.energy_red_layer2
	energy_orb_widget.energy_layer3 = ImageMaster.energy_red_layer3
	energy_orb_widget.energy_layer4 = ImageMaster.energy_red_layer4
	energy_orb_widget.energy_layer5 = ImageMaster.energy_red_layer5
	energy_orb_widget.energy_layer6 = ImageMaster.energy_red_layer6
	energy_orb_widget.energy_layer1d = ImageMaster.energy_red_layer1D
	energy_orb_widget.energy_layer2d = ImageMaster.energy_red_layer2D
	energy_orb_widget.energy_layer3d = ImageMaster.energy_red_layer3D
	energy_orb_widget.energy_layer4d = ImageMaster.energy_red_layer4D
	energy_orb_widget.energy_layer5d = ImageMaster.energy_red_layer5D


	energy_orb_widget.move_child(energy_orb_widget.layer1,0)
	energy_orb_widget.move_child(energy_orb_widget.layer2,1)
	energy_orb_widget.move_child(energy_orb_widget.layer3,2)
	energy_orb_widget.move_child(energy_orb_widget.layer4,3)
	energy_orb_widget.move_child(energy_orb_widget.layer5,4)
	energy_orb_widget.move_child(energy_orb_widget.layer6,5)
	energy_orb_widget.layer1.material = null

	
func update_orb_purple(orb_widget: EnergyOrbWidget) -> void:
	orb_widget.layer1.rotation_degrees = 0.0
	orb_widget.layer2.rotation_degrees = orb_widget.angle_l2 if orb_widget.enabled else 0.0
	orb_widget.layer3.rotation_degrees = orb_widget.angle_l3 if orb_widget.enabled else 0.0
	orb_widget.layer4.rotation_degrees = orb_widget.angle_l4 if orb_widget.enabled else 0.0


func get_energy_image() -> Texture2D:
	return ImageMaster.purple_orb_flash_vfx


func get_energy_num_label_settings() -> LabelSettings:
	return ThemeHelper.energy_num_purple_label_settings