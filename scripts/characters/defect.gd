class_name Defect
extends AbstractPlayer

static var character_string: CharacterString = null
static var NAMES : Array
static var TEXT : Array

const ID: String = "Defect"
const DEFECT_IDLE_ANIM = "defect_idle"
const DEFECT_HIT_ANIM = "defect_hit"

func _init() -> void:
	if character_string == null:
		character_string = CardGame.languagePack.get_character_string(ID)
		NAMES = character_string.NAMES
		TEXT = character_string.TEXT

	super(AbstractPlayer.PlayerType.DEFECT, DEFECT_IDLE_ANIM, DEFECT_HIT_ANIM)
	
	shoulder_img = ImageMaster.defect_shoulder_img
	shoulder2_img = ImageMaster.defect_shoulder2_img

func get_character_info() -> CharacterInfo:
	return CharacterInfo.new(
		NAMES[0],
		TEXT[0],
		75,
		75,
		3,
		99,
		5,
		self,
		get_starting_relics(),
		get_starting_deck(),
		false
	)

func get_starting_relics() -> Array :
	var result : Array = []
	result.append(RelicLibrary.get_relic("Cracked Core"))
	return result

func get_starting_deck() -> Array[String] :
	var result : Array[String] = []
	result.append(StrikeBlue.ID)
	result.append(StrikeBlue.ID)
	result.append(StrikeBlue.ID)
	result.append(StrikeBlue.ID)
	result.append(StrikeBlue.ID)

	result.append(DefendBlue.ID)
	result.append(DefendBlue.ID)
	result.append(DefendBlue.ID)
	result.append(DefendBlue.ID)
	result.append(DefendBlue.ID)

	result.append(Zap.ID)
	result.append(Dualcast.ID)
	return result

func get_card_trail_color() -> Color:
	return Color.SKY_BLUE

