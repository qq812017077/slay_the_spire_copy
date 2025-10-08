class_name IronClad
extends AbstractPlayer

static var character_string: CharacterString = null
static var CHARACTER_NAMES: Array
static var CHARACTER_TEXT: Array
const ID: String = "Ironclad"

const IRON_IDLE_ANIM = "iron_idle"
const IRON_HIT_ANIM = "iron_hit"

func _init() -> void:
	if character_string == null:
		character_string = CardGame.languagePack.get_character_string(ID)
		CHARACTER_NAMES = character_string.NAMES
		CHARACTER_TEXT = character_string.TEXT

	super (AbstractPlayer.PlayerType.IRONCLAD, IRON_IDLE_ANIM, IRON_HIT_ANIM)
	shoulder_img = ImageMaster.icon_clad_shoulder_img
	shoulder2_img = ImageMaster.icon_clad_shoulder2_img

	starting_max_health = 80
	max_health = starting_max_health
	current_health = max_health

func get_character_info() -> CharacterInfo:
	return CharacterInfo.new(
		CHARACTER_NAMES[0],
		CHARACTER_TEXT[0],
		80,
		80,
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
	result.append(RelicLibrary.get_relic("Burning Blood"))
	return result

func get_starting_deck() -> Array[String]:
	var result: Array[String] = []
	result.append(StrikeRed.ID)
	result.append(StrikeRed.ID)
	result.append(StrikeRed.ID)
	result.append(StrikeRed.ID)
	result.append(StrikeRed.ID)

	result.append(DefendRed.ID)
	result.append(DefendRed.ID)
	result.append(DefendRed.ID)
	result.append(DefendRed.ID)
	result.append(DefendRed.ID)

	result.append(Bash.ID)
	return result
	
func get_card_trail_color() -> Color:
	return Color(1.0, 0.4, 0.1, 1.0)


func setup_orb(energy_orb_widget: EnergyOrbWidget) -> void:
	energy_orb_widget.update_orb = update_orb_red
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

func update_orb_red(orb_widget: EnergyOrbWidget) -> void:
	orb_widget.layer1.rotation_degrees = orb_widget.angle_l1
	orb_widget.layer2.rotation_degrees = orb_widget.angle_l2
	orb_widget.layer3.rotation_degrees = orb_widget.angle_l3
	orb_widget.layer4.rotation_degrees = orb_widget.angle_l4
	orb_widget.layer5.rotation_degrees = orb_widget.angle_l5
	orb_widget.layer6.rotation_degrees = 0.0


func get_energy_image() -> Texture2D:
	return ImageMaster.red_orb_flash_vfx


func get_energy_num_label_settings() -> LabelSettings:
	return ThemeHelper.energy_num_red_label_settings
