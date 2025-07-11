class_name Watcher
extends AbstractPlayer

static var character_string: CharacterString = null
static var NAMES : Array
static var TEXT : Array


func _init() -> void:
	if character_string == null:
		character_string = CardGame.languagePack.get_character_string("Watcher")
		NAMES = character_string.NAMES
		TEXT = character_string.TEXT

	super(AbstractPlayer.PlayerType.WATCHER)

func get_character_info() -> CharacterInfo:
	return CharacterInfo.new(
		NAMES[0],
		TEXT[0],
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

func get_starting_relics() -> Array :
	var result : Array = []
	result.append(RelicLibrary.get_relic("PureWater"))
	return result

func get_starting_deck() -> Array :
	var result : Array = []
	return result