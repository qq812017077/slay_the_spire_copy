class_name Defect
extends AbstractPlayer

static var character_string: CharacterString = null
static var NAMES : Array
static var TEXT : Array


func _init() -> void:
	if character_string == null:
		character_string = CardGame.languagePack.get_character_string("Defect")
		NAMES = character_string.NAMES
		TEXT = character_string.TEXT

	super(AbstractPlayer.PlayerType.DEFECT)

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

func get_starting_deck() -> Array :
	var result : Array = []
	return result