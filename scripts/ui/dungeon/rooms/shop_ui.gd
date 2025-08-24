class_name ShopUI
extends Control

const MIN_IDLE_MSG_TIME: float = 40.0
const MAX_IDLE_MSG_TIME: float = 60.0

static var character_string: CharacterString = null
static var MERCHANT_NAMES: Array = []
static var MERCHANT_TEXT: Array = []
static var MERCHANT_ENDING_TEXT: Array = []

static var ui_string: UIString = null
static var SHOP_TEXTS: Array = []

static func initialize():
	character_string = CardGame.languagePack.get_character_string("Merchant")
	MERCHANT_NAMES = character_string.NAMES
	MERCHANT_TEXT = character_string.TEXT
	MERCHANT_ENDING_TEXT = character_string.OPTIONS

	ui_string = CardGame.languagePack.get_ui_string("ShopRoom")
	SHOP_TEXTS = ui_string.TEXT

@export var merchant: Control = null
@export var merchant_objects: Sprite2D = null
@export var merchant_player: AnimatedSprite2D = null

var merchant_btn: Button = null
var speech_timer: float = 0.0
var said_welcome: bool = false
var idle_messages: Array = []
func _ready() -> void:
	merchant_btn = ButtonHelper.create_fit_button(merchant)
	merchant_btn.mouse_entered.connect(_on_merchant_mouse_entered)
	merchant_btn.mouse_exited.connect(_on_merchant_mouse_exitd)
	merchant_btn.pressed.connect(_on_merchant_clicked)

func _process(delta: float) -> void:
	if not visible:
		return
	speech_timer -= delta
	if CardGame.dungeon_main_screen.cur_screen != DungeonMainScreen.ScreenType.SHOP:
		if speech_timer <= 0.0:
			var msg = idle_messages.pick_random()
			if msg == null:
				return 
			if not said_welcome:
				said_welcome = true
				welcome_sfx()
				msg = MERCHANT_NAMES[1]
			else:
				play_misc_sfx()
			# print("merchant_player.global_position:",merchant_player.global_position)
			CardGame.dungeon_main_screen.add_game_effect(SpeechBubble.create_speech_bubble(merchant_player.global_position, msg, 3.0, randi_range(0,1) == 0), false)
			speech_timer = randf_range(MIN_IDLE_MSG_TIME, MAX_IDLE_MSG_TIME)

func open():
	if visible:
		return
	visible = true
	merchant_player.play("idle")
	CardGame.dungeon_main_screen.overlay_menu.proceed_button.set_label(SHOP_TEXTS[0]);
	speech_timer = 1.5
	said_welcome = false
	if CardGame.dungeon_main_screen.dungeon.id == TheEnding.ID:
		idle_messages = MERCHANT_ENDING_TEXT
		CardGame.dungeon_main_screen.dungeon_shop_screen.set_msg(MERCHANT_ENDING_TEXT)
	else:
		idle_messages = MERCHANT_TEXT
		CardGame.dungeon_main_screen.dungeon_shop_screen.set_default_msg()
	build_shop()

func close():
	if not visible:
		return
	visible = false


func welcome_sfx() -> void:
	var roll = randi_range(1, 2)
	if roll == 0:
		CardGame.sound.single_play("VO_MERCHANT_3A")
	elif roll == 1:
		CardGame.sound.single_play("VO_MERCHANT_3B")
	else:
		CardGame.sound.single_play("VO_MERCHANT_3C")

func play_misc_sfx() -> void:
	var roll = randi_range(0, 5)
	if roll == 0:
		CardGame.sound.single_play("VO_MERCHANT_MA")
	elif roll == 1:
		CardGame.sound.single_play("VO_MERCHANT_MB")
	elif roll == 2:
		CardGame.sound.single_play("VO_MERCHANT_MC")
	elif roll == 3:
		CardGame.sound.single_play("VO_MERCHANT_3A")
	elif roll == 4:
		CardGame.sound.single_play("VO_MERCHANT_3B")
	else:
		CardGame.sound.single_play("VO_MERCHANT_3C")

func _on_merchant_mouse_entered() -> void:
	merchant_objects.modulate = Color.WHITE * 1.5
	pass

func _on_merchant_mouse_exitd() -> void:
	merchant_objects.modulate = Color.WHITE
	pass

func _on_merchant_clicked() -> void:
	CardGame.dungeon_main_screen.overlay_menu.proceed_button.set_label(MERCHANT_NAMES[0]);
	CardGame.dungeon_main_screen.overlay_menu.proceed_button.hide_button()
	CardGame.dungeon_main_screen.open_screen(DungeonMainScreen.ScreenType.SHOP)
	said_welcome = true

func build_shop() -> void:
	build_shop_cards()
	CardGame.dungeon_main_screen.dungeon_shop_screen.init_shop_ui()

func build_shop_cards() -> void:
	var colored_cards: Array = []
	colored_cards.append(generate_colored_card(AbstractCard.CardType.ATTACK))
	colored_cards.append(generate_colored_card(AbstractCard.CardType.ATTACK))
	colored_cards.append(generate_colored_card(AbstractCard.CardType.SKILL))
	colored_cards.append(generate_colored_card(AbstractCard.CardType.SKILL))
	colored_cards.append(generate_colored_card(AbstractCard.CardType.POWER))

	var colorless_cards: Array = []
	colorless_cards.append(CardGame.dungeon_main_screen.get_colorless_card_from_pool(AbstractCard.CardRarity.UNCOMMON).make_copy())
	colorless_cards.append(CardGame.dungeon_main_screen.get_colorless_card_from_pool(AbstractCard.CardRarity.RARE).make_copy())

	CardGame.dungeon_main_screen.dungeon_shop_screen.load_card_and_price(colored_cards, colorless_cards)
func generate_colored_card(card_type: AbstractCard.CardType) -> AbstractCard:
	var card: AbstractCard = CardGame.dungeon_main_screen.get_card_from_pool(CardGame.dungeon_main_screen.roll_rarity(), card_type, true).make_copy()
	while true:
		if card.color != AbstractCard.CardColor.COLORLESS:
			break
		card = CardGame.dungeon_main_screen.get_card_from_pool(CardGame.dungeon_main_screen.roll_rarity(), card_type, true).make_copy()
	return card
