class_name AbstractPlayer
extends AbstractCreature
enum PlayerType {IRONCLAD, THE_SILENT, DEFECT, WATCHER}

static func initialize():
	pass


var type: PlayerType
var idle_animation: String = "idle"
var hit_animation: String = "hit"
var shoulder_img: Texture2D = null
var shoulder2_img: Texture2D = null

var master_max_orbs: int = 0
var energy_manager: EnergyManager
var master_hand_size: int = 0

var orbs: Array[AbstractOrb] = []

var relics: Array[AbstractRelic] = []
var blights: Array[AbstracBlight] = []

var cards_played_count_this_turn: int = 0

var master_decks: CardGroup = CardGroup.new(CardGroup.CardGroupType.MASTER_DECK)
var draw_pile: CardGroup = CardGroup.new(CardGroup.CardGroupType.DRAW_PILE)
var hand: CardGroup = CardGroup.new(CardGroup.CardGroupType.HAND)
var discard_pile: CardGroup = CardGroup.new(CardGroup.CardGroupType.DISCARD_PILE)
var exhaust_pile: CardGroup = CardGroup.new(CardGroup.CardGroupType.EXHAUST_PILE)


func _init(_type: PlayerType, _idle_animation: String, _hit_animation: String, emanager: EnergyManager = EnergyManager.new(3)) -> void:
	type = _type
	idle_animation = _idle_animation
	hit_animation = _hit_animation
	master_max_orbs = 3
	gold = 99
	master_hand_size = 10
	energy_manager = emanager

	
func new_instance() -> AbstractPlayer:
	return null

func get_character_info() -> CharacterInfo:
	return null

func get_starting_deck() -> Array[String]:
	return []

func get_upgradeable_cards() -> Array[AbstractCard]:
	return master_decks.group.filter(
		func(card: AbstractCard) -> bool:
			return card.is_upgradable()
	)
func get_purgeable_cards() -> Array[AbstractCard]:
	return master_decks.group.filter(
		func(card: AbstractCard) -> bool:
			return card.is_purgeable()
	)

func gain_gold(gold_amt: int) -> void:
	gold += gold_amt
func lose_gold(gold_amt: int) -> void:
	gold -= gold_amt

func has_relic(relic_id: String) -> bool:
	for relic : AbstractRelic in relics:
		if relic.relicId == relic_id:
			return true
	return false

func initialize_starting_deck() -> void:
	var cards: Array[String] = get_starting_deck()
	for card_name in cards:
		master_decks.add_to_top(CardLibrary.get_card(card_name).make_copy())

func get_card_trail_color() -> Color:
	return Color.WHITE


func on_end_of_turn():
	for c: AbstractCard in hand.group:
		c.trigger_on_end_of_turn_for_playing_cards()

func setup_orb(_energy_orb: EnergyOrbWidget) -> void:
	pass

func get_energy_image() -> Texture2D:
	return null

func get_energy_num_label_settings() -> LabelSettings:
	return null

func draw_card() -> AbstractCard:
	var card: AbstractCard = draw_pile.pop_top_card()
	hand.add_to_top(card)
	return card

func create_hand_is_full_dialog():
	pass
static func get_character_name(player_type: PlayerType) -> String:
	match player_type:
		PlayerType.IRONCLAD:
			return ""
		PlayerType.THE_SILENT:
			return ""
		PlayerType.DEFECT:
			return ""
		PlayerType.WATCHER:
			return ""

	return ""

static func get_character_relic(player_type: PlayerType) -> AbstractRelic:
	match player_type:
		PlayerType.IRONCLAD:
			return RelicLibrary.get_relic("Burning Blood")
			
		PlayerType.THE_SILENT:
			return RelicLibrary.get_relic("Ring of the Snake")
			
		PlayerType.DEFECT:
			return RelicLibrary.get_relic("Cracked Core")
			
		PlayerType.WATCHER:
			return RelicLibrary.get_relic("PureWater")
			
	return
