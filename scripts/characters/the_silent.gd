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