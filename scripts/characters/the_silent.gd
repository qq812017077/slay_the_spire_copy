class_name TheSilent
extends AbstractPlayer

static var character_string: CharacterString = null
static var CHARACTER_NAMES: Array
static var CHARACTER_TEXT: Array
const ID: String = "Silent"

const SILENT_IDLE_ANIM = "silent_idle"
const SILENT_HIT_ANIM = "silent_hit"

func _init() -> void:
	if character_string == null:
		character_string = CardGame.languagePack.get_character_string(ID)
		CHARACTER_NAMES = character_string.NAMES
		CHARACTER_TEXT = character_string.TEXT

	super (AbstractPlayer.PlayerType.THE_SILENT, SILENT_IDLE_ANIM, SILENT_HIT_ANIM)
	
	shoulder_img = ImageMaster.the_silent_shoulder_img
	shoulder2_img = ImageMaster.the_silent_shoulder2_img
func get_character_info() -> CharacterInfo:
	return CharacterInfo.new(
		CHARACTER_NAMES[0],
		CHARACTER_TEXT[0],
		70,
		70,
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
	result.append(RelicLibrary.get_relic("Ring of the Snake"))
	return result

func get_starting_deck() -> Array[String]:
	var result: Array[String] = []
	result.append(StrikeGreen.ID)
	result.append(StrikeGreen.ID)
	result.append(StrikeGreen.ID)
	result.append(StrikeGreen.ID)
	result.append(StrikeGreen.ID)

	result.append(DefendGreen.ID)
	result.append(DefendGreen.ID)
	result.append(DefendGreen.ID)
	result.append(DefendGreen.ID)
	result.append(DefendGreen.ID)

	result.append(Survivor.ID)
	result.append(Neutralize.ID)
	return result


func get_card_trail_color() -> Color:
	return Color.CHARTREUSE

func setup_orb(energy_orb_widget: EnergyOrbWidget) -> void:
	energy_orb_widget.update_orb = update_orb_green
	energy_orb_widget.energy_layer1 = ImageMaster.energy_green_layer1
	energy_orb_widget.energy_layer2 = ImageMaster.energy_green_layer2
	energy_orb_widget.energy_layer3 = ImageMaster.energy_green_layer3
	energy_orb_widget.energy_layer4 = ImageMaster.energy_green_layer4
	energy_orb_widget.energy_layer5 = ImageMaster.energy_green_layer5
	energy_orb_widget.energy_layer6 = ImageMaster.energy_green_layer6
	energy_orb_widget.energy_layer1d = ImageMaster.energy_green_layer1D
	energy_orb_widget.energy_layer2d = ImageMaster.energy_green_layer2D
	energy_orb_widget.energy_layer3d = ImageMaster.energy_green_layer3D
	energy_orb_widget.energy_layer4d = ImageMaster.energy_green_layer4D
	energy_orb_widget.energy_layer5d = ImageMaster.energy_green_layer5D

	energy_orb_widget.move_child(energy_orb_widget.layer2,0)
	energy_orb_widget.move_child(energy_orb_widget.layer3,1)
	energy_orb_widget.move_child(energy_orb_widget.layer4,2)
	energy_orb_widget.move_child(energy_orb_widget.layer5,3)
	energy_orb_widget.move_child(energy_orb_widget.layer1,4)
	energy_orb_widget.move_child(energy_orb_widget.layer6,5)
	energy_orb_widget.layer1.material = MaterialLibrary.add_material

func update_orb_green(orb_widget: EnergyOrbWidget) -> void:
	orb_widget.layer2.rotation_degrees = 0.0 if orb_widget.enabled else orb_widget.angle_l2
	orb_widget.layer3.rotation_degrees = 0.0
	orb_widget.layer4.rotation_degrees = orb_widget.angle_l3
	orb_widget.layer5.rotation_degrees = 0.0
	orb_widget.layer1.rotation_degrees = orb_widget.angle_l4
	orb_widget.layer6.rotation_degrees = 0.0


func get_energy_image() -> Texture2D:
	return ImageMaster.green_orb_flash_vfx


func get_energy_num_label_settings() -> LabelSettings:
	return ThemeHelper.energy_num_green_label_settings