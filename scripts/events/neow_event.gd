class_name NeowEvent
extends AbstractEvent

const DIALOG_POS: Vector2 = Vector2(1050, AbstractDungeons.floorY - 240)

static var character_string: CharacterString = null
static var NAME: Array
static var TEXT: Array
static var OPTIONS: Array

static var ID: String = "Neow Event"

enum EventStage {INTRO, SELECT, END}

var screen_num: int = 0
var boss_count: int = 0

var neow_rewards: Array[NeowReward] = []

func _init(is_done: bool = false) -> void:
	if character_string == null:
		character_string = CardGame.languagePack.get_character_string(ID)
		NAME = character_string.NAMES
		TEXT = character_string.TEXT
		OPTIONS.assign(character_string.OPTIONS)
	
	super (EventType.ROOM, "", "", null)

	play_sfx()
	if CardGame.dungeon_main_screen.floor_num <= 1:
		if Settings.is_standard_run() or (Settings.is_end_less and CardGame.dungeon_main_screen.floor_num <= 1):
			boss_count = 0
		elif Settings.seedSet:
			boss_count = 1
		else:
			boss_count = 0
	options.clear()
	screen_num = 2
	if Settings.is_end_less and CardGame.dungeon_main_screen.floor_num > 1:
		options.append(OPTIONS[0])
		screen_num = 999
	elif not is_done:
		screen_num = 0
		talk(TEXT[randi_range(1, 3)])
		options.append(OPTIONS[1])
	else:
		screen_num = 99
		talk(TEXT[8])
		options.append(OPTIONS[3])


func setup_to_room_event_dialog(_room_event_dialog: RoomEventDialog) -> void:
	_room_event_dialog.animated_npc.sprite_frames = CardGame.anim_library.neow_anim
	_room_event_dialog.animated_npc.position = Vector2(1534, 455)
	_room_event_dialog.animated_npc.play("idle")
	pass

func talk(text: String) -> void:
	print("talk:", text)
	CardGame.dungeon_main_screen.add_game_effect(SpeechBubble.create_infinite_speech_bubble(DIALOG_POS, text))

func on_option_selected(_option_slot: int) -> OptionResult:
	print("screen_num:", screen_num)
	print("boss_count:", boss_count)

	if screen_num == 0:
		talk(TEXT[4])
		if boss_count != 0:
			return blessing()
		else:
			return mini_blessing()
	elif screen_num == 1:
		if boss_count == 0:
			return mini_blessing()
		else:
			return blessing()
	elif screen_num == 2:
		if _option_slot == 0:
			return blessing()
		else:
			return OptionResult.ReturnMap
	elif screen_num == 3:
		screen_num = 99
		match _option_slot:
			0:
				neow_rewards[0].activate()
				talk(TEXT[8])
			1:
				neow_rewards[1].activate()
				talk(TEXT[8])
			2:
				neow_rewards[2].activate()
				talk(TEXT[9])
			3:
				neow_rewards[3].activate()
				talk(TEXT[9])
		var result: OptionResult = OptionResult.new()
		result.options.append(OPTIONS[3])
		CardGame.dungeon_main_screen.dungeon_room_screen.end_room()
		return result

	elif screen_num == 10:
		daily_blessing()
		screen_num = 99
		var result: OptionResult = OptionResult.new()
		result.options.append(OPTIONS[3])
		CardGame.dungeon_main_screen.dungeon_room_screen.end_room()
		return result
	elif screen_num == 999:
		endless_blessing()
		screen_num = 99
		var result: OptionResult = OptionResult.new()
		result.options.append(OPTIONS[3])
		CardGame.dungeon_main_screen.dungeon_room_screen.end_room()
		return result

	return OptionResult.ReturnMap

func blessing() -> OptionResult:
	var result: OptionResult = OptionResult.new()

	talk(TEXT[7])
	neow_rewards.clear()
	neow_rewards.append(NeowReward.create_by_category(0))
	neow_rewards.append(NeowReward.create_by_category(1))
	neow_rewards.append(NeowReward.create_by_category(2))
	neow_rewards.append(NeowReward.create_by_category(3))

	result.options.append(neow_rewards[0].option_label)
	result.options.append(neow_rewards[1].option_label)
	result.options.append(neow_rewards[2].option_label)
	result.options.append(neow_rewards[3].option_label)
	screen_num = 3
	return result

func mini_blessing() -> OptionResult:
	var result: OptionResult = OptionResult.new()
	talk(TEXT[randi_range(4, 6)])

	neow_rewards.clear()
	neow_rewards.append(NeowReward.create_by_mini(true))
	neow_rewards.append(NeowReward.create_by_mini(false))

	result.options.append(neow_rewards[0].option_label)
	result.options.append(neow_rewards[1].option_label)
	screen_num = 3
	return result

func daily_blessing() -> void:
	return

func endless_blessing() -> void:
	return
func play_sfx() -> void:
	var roll = randi_range(0, 3)
	if roll == 0:
		CardGame.sound.single_play("VO_NEOW_1A")
	elif roll == 1:
		CardGame.sound.single_play("VO_NEOW_1B")
	elif roll == 2:
		CardGame.sound.single_play("VO_NEOW_2A")
	else:
		CardGame.sound.single_play("VO_NEOW_2B")
	pass
