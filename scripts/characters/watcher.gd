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
