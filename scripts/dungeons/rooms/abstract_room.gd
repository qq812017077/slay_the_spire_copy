class_name AbstractRoom
extends Object

enum RoomPhase {COMBAT, EVENT, COMPLETE, INCOMPLETE, NONE}
enum RoomType {REST, SHOP, MONSTER, SHRINE, TREASURE, EVENT, ELITE, BOSS, NEOW, EMPTY}

static var ui_string: UIString
static var TEXT: Array

var phase: RoomPhase
var type: RoomType

var map_symbol: String
var map_img: Texture2D
var map_img_outline: Texture2D
var is_batter_over: bool = false

var base_rare_card_chance: int = 3
var base_uncommon_card_chance: int = 37
var rare_card_chance: int = base_rare_card_chance
var uncommon_card_chance: int = base_uncommon_card_chance

# monster
var monsters: MonsterGroup = null
var skip_monster_turn: bool = false

# event
var event: AbstractEvent = null

func _init(_phase: RoomPhase, symbol: String, img: Texture2D, img_outline: Texture2D) -> void:
	phase = _phase
	map_symbol = symbol
	map_img = img
	map_img_outline = img_outline
	set_type_by_symbol(symbol)

func set_type_by_symbol(symbol: String) -> void:
	if symbol == "R":
		type = RoomType.REST
	elif symbol == "$":
		type = RoomType.SHOP
	elif symbol == "M":
		type = RoomType.MONSTER
	elif symbol == "H":
		type = RoomType.SHRINE
	elif symbol == "T":
		type = RoomType.TREASURE
	elif symbol == "E":
		type = RoomType.EVENT
	elif symbol == "L":
		type = RoomType.ELITE
	elif symbol == "B":
		type = RoomType.BOSS
	elif symbol == "N":
		type = RoomType.NEOW
	else:
		push_error(("Invalid room symbol: {0}").format([symbol]))

func on_player_entry():
	pass

func apply_end_of_turn_relic():
	for relic in CardGame.dungeon_main_screen.player.relics:
		relic.on_player_end_turn()
	for blight in CardGame.dungeon_main_screen.player.blights:
		blight.on_player_end_turn()
	
func apply_end_of_turn_pre_card_powers():
	for power : AbstractPower in CardGame.dungeon_main_screen.player.powers:
		# power.at_end_()
		pass
	
func get_card_rarity(roll: int) -> AbstractCard.CardRarity:
	return get_card_rarity_with_alter_prob(roll, true)

func get_card_rarity_with_alter_prob(roll: int, use_alternation: bool) -> AbstractCard.CardRarity:
	rare_card_chance = base_rare_card_chance
	uncommon_card_chance = base_uncommon_card_chance

	if use_alternation:
		alter_card_rarity_probabilities()
    
	if roll < rare_card_chance:
		return AbstractCard.CardRarity.RARE
	elif roll < (rare_card_chance + uncommon_card_chance):
		return AbstractCard.CardRarity.UNCOMMON
	else:
		return AbstractCard.CardRarity.COMMON

func alter_card_rarity_probabilities() -> void:
	# relic alter prob
	pass