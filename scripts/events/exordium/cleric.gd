class_name Cleric
extends AbstractEvent

static var event_string: EventString = null
static var NAME: String
static var DESCRIPTIONS: Array
static var OPTIONS: Array

static var ID: String = "The Cleric"

enum EventStage {INTRO, END}

var healAmt: int = 0
var stage: EventStage = EventStage.INTRO
func _init() -> void:
	if event_string == null:
		event_string = CardGame.languagePack.get_event_string(ID)
		NAME = event_string.NAME
		DESCRIPTIONS = event_string.DESCRIPTIONS
		OPTIONS.assign(event_string.OPTIONS)

	super (EventType.IMAGE, NAME, DESCRIPTIONS[0], ImageMaster.event_img_cleric)

	# if CardGame.dungeon_main_screen and CardGame.dungeon_main_screen.player.gold >= 35:
	# 	options.append(OPTIONS[0] + str(healAmt) + OPTIONS[8])
	# 	options.append(OPTIONS[1] + "#" + OPTIONS[2])
	# 	options.append(OPTIONS[4])

func on_option_selected(option_slot: int) -> OptionResult:
	var result: OptionResult = OptionResult.new()
	if stage == EventStage.INTRO:
		if option_slot == 0:
			result.body = DESCRIPTIONS[1]
			result.options.append(OPTIONS[5])
		elif option_slot == 1:
			result.body = DESCRIPTIONS[2]
			result.options.append(OPTIONS[5])
		else:
			result.body = DESCRIPTIONS[4] + DESCRIPTIONS[5]
			result.options.append(OPTIONS[5])
		stage = EventStage.END
	elif stage == EventStage.END:
		result.return_map = true
	else:
		push_error("Invalid event stage: ", stage)
	return result


func is_finished() -> bool:
	return stage == EventStage.END
