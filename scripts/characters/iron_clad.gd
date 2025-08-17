class_name IronClad
extends AbstractPlayer

static var character_string: CharacterString = null
static var NAMES: Array
static var TEXT: Array
const ID: String = "Ironclad"

const IRON_IDLE_ANIM = "iron_idle"
const IRON_HIT_ANIM = "iron_hit"

func _init() -> void:
	if character_string == null:
		character_string = CardGame.languagePack.get_character_string(ID)
		NAMES = character_string.NAMES
		TEXT = character_string.TEXT

	super (AbstractPlayer.PlayerType.IRONCLAD, IRON_IDLE_ANIM, IRON_HIT_ANIM)
	shoulder_img = ImageMaster.icon_clad_shoulder_img
	shoulder2_img = ImageMaster.icon_clad_shoulder2_img

	starting_max_health = 80
	max_health = starting_max_health
	current_health = max_health
func get_character_info() -> CharacterInfo:
	return CharacterInfo.new(
		NAMES[0],
		TEXT[0],
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