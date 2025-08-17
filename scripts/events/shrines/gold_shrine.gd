class_name GoldShrine
extends AbstractEvent

static var event_string: EventString = null
static var NAME: String
static var DESCRIPTIONS: Array
static var OPTIONS: Array

static var ID: String = "Golden Shrine"

enum EventStage {INTRO, END}
var goldAmt: int = 100
var stage: EventStage = EventStage.INTRO
func _init() -> void:
	if event_string == null:
		event_string = CardGame.languagePack.get_event_string(ID)
		NAME = event_string.NAME
		DESCRIPTIONS = event_string.DESCRIPTIONS
		OPTIONS.assign(event_string.OPTIONS)
	
	super (EventType.IMAGE, NAME, DESCRIPTIONS[0], ImageMaster.event_img_gold_shrine)

	options.append(OPTIONS[0] + str(goldAmt) + OPTIONS[1])
	options.append(OPTIONS[2])
	options.append(OPTIONS[3])

func on_option_selected(option_slot: int) -> OptionResult:
	var result: OptionResult = OptionResult.new()
	if stage == EventStage.INTRO:
		if option_slot == 0:
			result.body = DESCRIPTIONS[1]
		elif option_slot == 1:
			result.body = DESCRIPTIONS[2]
		else:
			result.body = DESCRIPTIONS[3]
		result.options.append(OPTIONS[3])
		stage = EventStage.END
	elif stage == EventStage.END:
		result.return_map = true
	else:
		push_error("Invalid event stage: ", stage)
	return result


func is_finished() -> bool:
	return stage == EventStage.END