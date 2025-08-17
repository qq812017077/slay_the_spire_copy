class_name ShopScreen
extends Control

const START_Y: float = -142 - Settings.DEFAULT_HEIGHT
const OPEN_Y: float = -42
const OPENING_SPEED: float = 5
const HAND_INIT_POS: Vector2 = Vector2(float(Settings.DEFAULT_WIDTH) / 2, -100)
const HAND_OFFSET: Vector2 = Vector2(80, -100)

const H_SEPARATION: float = 60
const RM_PRICE_INCREASE_AMOUNT: int = 50
static var character_string: CharacterString = null
static var SHOP_NAMES: Array = []
static var SHOP_TEXT: Array = []

static var HOVERING_SCALE: Vector2 = Vector2(1.3, 1.3)
static var NORMAL_SCALE: Vector2 = Vector2(1, 1)
static var RECOVERING_SCALE: Vector2 = Vector2(0.8, 0.8)

static func initialize() -> void:
	character_string = CardGame.languagePack.get_character_string("Shop Screen")
	SHOP_NAMES = character_string.NAMES
	SHOP_TEXT = character_string.TEXT

@export var bg: Sprite2D = null
@export var remove_service_img: Sprite2D = null
@export var hand: Sprite2D = null

@export_group("content")
@export var price_prefab: PackedScene = null
@export var price_container: Control = null
@export var colored_cards_container: Control = null
@export var colorless_cards_container: Control = null
@export var relics_container: Control = null
@export var potions_container: Control = null
@export_group("")


var move_speed: float = 10
var remove_img: Texture2D = null
var sold_out_img: Texture2D = null
var floaty_effect: FloatyEffect = null
var hand_target_pos: Vector2

var remove_service_btn: Button = null

var cardwidgets: Array = []
var card_price_mapping: Dictionary = {}
var can_update_hand: bool = false
var is_showing: bool = false
var some_hovering: bool = false
var hovering_timer: float = 0
var rm_price: int = 50
var rm_available: bool = false:
	set = set_rm_available
var rm_price_widget: PriceWidget = null
@onready var content: Control = $Content
@onready var remove_service: Control = $Content/RemoveService
func _ready() -> void:
	floaty_effect = FloatyEffect.new(20.0, 0.1)

	bg.texture = ImageMaster.get_rug_image()
	remove_img = ImageMaster.get_remove_service_image()
	sold_out_img = ImageMaster.get_sold_out_image()
	
	remove_service.size = remove_service_img.region_rect.size * remove_service_img.scale
	remove_service.pivot_offset = remove_service.size / 2
	remove_service_btn = ButtonHelper.create_fit_button(remove_service_img.get_parent())

	# remove service
	rm_price_widget = price_prefab.instantiate()
	rm_price_widget.update_price(rm_price)
	price_container.add_child(rm_price_widget)
	rm_price_widget.bind(remove_service_btn)
	remove_service_btn.pressed.connect(_on_rm_service_pressed)
	close()
	
func _process(delta: float) -> void:
	if not is_showing:
		return
	floaty_effect.update(delta)
	update_position(delta)
	update_cards(delta)
	update_remove_service(delta)
	update_hand(delta)

	
	if not some_hovering:
		hovering_timer -= delta
		if hovering_timer < 0:
			move_hand(HAND_INIT_POS)
	
func update_position(delta: float) -> void:
	content.position.y = MathHelper.lerp_snap(content.position.y, OPEN_Y, delta * OPENING_SPEED)

func update_cards(delta: float) -> void:
	var clamp_delta = clamp(delta, 0.001, 0.02)
	some_hovering = false
	for card: CardWidget in cardwidgets:
		if card.is_hovering():
			move_hand(card.global_position + card.size / 2)
			hovering_timer = 1.0
			some_hovering = true
			if (card.scale - HOVERING_SCALE).length_squared() > Global.EPLISON:
				# card.scale = card.scale.lerp(HOVERING_SCALE, delta * move_speed * 10)
				card.scale = MathHelper.vec2_lerp_snap(card.scale, HOVERING_SCALE, clamp_delta * move_speed * 10)
			else:
				card.scale = HOVERING_SCALE
			card.z_index = 1
		else:
			if (card.scale - NORMAL_SCALE).length_squared() > Global.EPLISON:
				# card.scale = card.scale.lerp(NORMAL_SCALE, delta * move_speed)
				card.scale = MathHelper.vec2_lerp_snap(card.scale, NORMAL_SCALE, clamp_delta * move_speed)
			else:
				card.scale = NORMAL_SCALE
			card.z_index = 0

func update_remove_service(delta: float) -> void:
	var clamp_delta = clamp(delta, 0.001, 0.02)
	if rm_available and remove_service_btn.is_hovered():
		move_hand(remove_service_btn.global_position + remove_service_btn.size / 2)
		hovering_timer = 1.0
		some_hovering = true
		remove_service.scale = MathHelper.vec2_lerp_snap(remove_service.scale, HOVERING_SCALE, clamp_delta * move_speed * 10)
		remove_service.z_index = 1
	else:
		remove_service.scale = MathHelper.vec2_lerp_snap(remove_service.scale, NORMAL_SCALE, clamp_delta * move_speed)
		remove_service.z_index = 0

func move_hand(pos: Vector2) -> void:
	hand_target_pos = pos / Settings.scale + HAND_OFFSET

func update_hand(delta: float) -> void:
	if can_update_hand:
		hand.position.x = MathHelper.lerp_snap(hand.position.x, hand_target_pos.x, delta * 6.0)
		if hand.position.y < hand_target_pos.y:
			hand.position.y = MathHelper.lerp_snap(hand.position.y, hand_target_pos.y, delta * 6.0)
		elif hand.position.y > hand_target_pos.y:
			hand.position.y = MathHelper.lerp_snap(hand.position.y, hand_target_pos.y, delta * 1.5)

func open() -> void:
	if is_showing:
		return
	visible = true
	is_showing = true
	CardGame.sound.single_play("SHOP_OPEN")
	# set_starting_card_positions()
	content.position.y = START_Y
	hand.position = HAND_INIT_POS
	hand_target_pos = hand.position
	can_update_hand = false
	var timer = get_tree().create_timer(1)
	timer.timeout.connect(func() -> void: can_update_hand = true)

	
	refresh_price_color()

func close() -> void:
	if not is_showing:
		return
	
	CardGame.sound.single_play("SHOP_CLOSE")
	is_showing = false
	visible = false
	can_update_hand = false
	content.position.y = START_Y
	hand.position = HAND_INIT_POS
	hand_target_pos = hand.position

func load_card_and_price(colored_cards: Array, colorless_cards: Array) -> void:
	for card: CardWidget in cardwidgets:
		card_price_mapping[card].queue_free()
		CardWidget.recycle(card)
	cardwidgets.clear()

	card_price_mapping.clear()

	var colored_cardwidgets = CardWidget.generate_cardwidgets(colored_cards, colored_cards_container, 0.9, true)
	var colorless_cardwidgets = CardWidget.generate_cardwidgets(colorless_cards, colorless_cards_container, 0.9, true)
	init_card(colored_cardwidgets)
	init_card(colorless_cardwidgets)

	cardwidgets.append_array(colored_cardwidgets)
	cardwidgets.append_array(colorless_cardwidgets)

	for card_widget: CardWidget in cardwidgets:
		var price_widget: PriceWidget = price_prefab.instantiate()
		price_widget.update_price(AbstractCard.get_price(card_widget.card))
		price_container.add_child(price_widget)
		price_widget.bind(card_widget)
		card_price_mapping[card_widget] = price_widget


func init_card(_cardwidgets: Array) -> void:
	var cur_x_pos: float = 0
	for card: CardWidget in _cardwidgets:
		card.size = card.get_minimum_size()
		card.position.x = cur_x_pos
		card.position.y = 0
		cur_x_pos += card.size.x + H_SEPARATION

		card.on_card_clicked = self._on_card_widget_clicked

func init_shop_ui() -> void:
	rm_available = true

func set_rm_available(available: bool) -> void:
	# print("set_rm_available:", available)
	rm_available = available
	if rm_available:
		remove_service_img.texture = remove_img
		rm_price_widget.visible = true
	else:
		remove_service_img.texture = sold_out_img
		rm_price_widget.visible = false

func purge_card() -> void:
	rm_available = false
	CardGame.dungeon_main_screen.player.use_gold(rm_price)
	rm_price += RM_PRICE_INCREASE_AMOUNT
	refresh_price_color()

func refresh_price_color() -> void:
	rm_price_widget.update_price(rm_price)
	if rm_available:
		rm_price_widget.refresh_price_color()
	
	for card: CardWidget in card_price_mapping.keys():
		card_price_mapping[card].refresh_price_color()
func _on_card_widget_clicked(card_widget: CardWidget) -> void:
	var price_widget: PriceWidget = card_price_mapping[card_widget]
	if CardGame.dungeon_main_screen.player.gold >= price_widget.priceAmt:
		CardGame.dungeon_main_screen.player.use_gold(price_widget.priceAmt)
		var obtain_timer = get_tree().create_timer(0.1)
		obtain_timer.timeout.connect(func() -> void:
			card_widget.scale = NORMAL_SCALE
			card_price_mapping[card_widget].queue_free()
			card_price_mapping.erase(card_widget)
			cardwidgets.erase(card_widget)
			CardGame.soul.obtain_card(card_widget)
			)
	
	refresh_price_color()
func _on_rm_service_pressed() -> void:
	if not rm_available:
		return
	refresh_price_color()
	if CardGame.dungeon_main_screen.player.gold >= rm_price:
		CardGame.dungeon_main_screen.open_screen(DungeonMainScreen.ScreenType.PURGE_DECK_VIEW)
