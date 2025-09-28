class_name HandPanel
extends AbstractPanel

var CARD_X_COORD_TABLE: Dictionary = {}
var CARD_Y_OFFSET_TABLE: Dictionary = {}

var player: AbstractPlayer = null

var hand_card_widgets: Array[CardWidget] = []

func _ready() -> void:
	build_pos_table()

func load_player(_player: AbstractPlayer) -> void:
	player = _player

func add_to_hand(card: CardWidget) -> void:
	hand_card_widgets.append(card)

func on_combat_start() -> void:
	pass
	
		
func refresh_layout() -> void:
	
	for relic : AbstractRelic in player.relics:
		relic.on_refresh_hand()
	
	var hand_group_size: int = player.hand.group.size()
	var angle_range : float= 50.0 - ( 10 - hand_group_size) * 5.0
	var increment_angle : float = angle_range / hand_group_size
	var sink_start : float = 80.0
	var sink_range : float = 300.0
	var increment_sink: float = sink_range / hand_group_size / 2.0
	var middle = hand_group_size / 2

	var even_count: bool = hand_group_size % 2 == 0
	for i: int in range(hand_group_size):
		hand_card_widgets[i].set_target_angle(angle_range / 2.0 - increment_angle * i - increment_angle / 2.0)

		var t: int = i - middle
		
		if t >= 0:
			if even_count:
				t += 1
			t = -t
		
		if even_count:
			t += 1
		t = int(t * 1.7)

		var target_y : float= sink_start + increment_sink * t
		hand_card_widgets[i].target_pos = Vector2(CARD_X_COORD_TABLE[hand_group_size][i], target_y)

	glow_check()

func glow_check() -> void:
	for card_widget: CardWidget in hand_card_widgets:
		if card_widget.card.can_use(player, null):
			card_widget.begin_glow()
		else:
			card_widget.stop_glow()

func stop_glowing():
	for card_widget: CardWidget in hand_card_widgets:
		card_widget.stop_glow()

func build_pos_table() -> void:
	var middle_pos_x: float = Settings.DEFAULT_WIDTH / 2.0
	for i in range(1, 10):
		CARD_X_COORD_TABLE.set(i, {})
		CARD_Y_OFFSET_TABLE.set(i, {})
	
	# 1 card in hand
	CARD_X_COORD_TABLE[1][0] = middle_pos_x

	# 2 card in hand
	CARD_X_COORD_TABLE[2][0] = middle_pos_x - AbstractCard.IMG_WIDTH_S * 0.47
	CARD_X_COORD_TABLE[2][1] = middle_pos_x + AbstractCard.IMG_WIDTH_S * 0.53

	# 3 card in hand
	CARD_X_COORD_TABLE[3][0] = middle_pos_x - AbstractCard.IMG_WIDTH_S * 0.9
	CARD_X_COORD_TABLE[3][1] = middle_pos_x
	CARD_X_COORD_TABLE[3][2] = middle_pos_x + AbstractCard.IMG_WIDTH_S * 0.9

	# 4 card in hand
	CARD_X_COORD_TABLE[4][0] = middle_pos_x - AbstractCard.IMG_WIDTH_S * 1.36
	CARD_X_COORD_TABLE[4][1] = middle_pos_x - AbstractCard.IMG_WIDTH_S * 0.46
	CARD_X_COORD_TABLE[4][2] = middle_pos_x + AbstractCard.IMG_WIDTH_S * 0.46
	CARD_X_COORD_TABLE[4][3] = middle_pos_x + AbstractCard.IMG_WIDTH_S * 1.36

	# 5 card in hand
	CARD_X_COORD_TABLE[5][0] = middle_pos_x - AbstractCard.IMG_WIDTH_S * 1.7
	CARD_X_COORD_TABLE[5][1] = middle_pos_x - AbstractCard.IMG_WIDTH_S * 0.9
	CARD_X_COORD_TABLE[5][2] = middle_pos_x
	CARD_X_COORD_TABLE[5][3] = middle_pos_x + AbstractCard.IMG_WIDTH_S * 0.9
	CARD_X_COORD_TABLE[5][4] = middle_pos_x + AbstractCard.IMG_WIDTH_S * 1.7

	# 6 card in hand
	CARD_X_COORD_TABLE[6][0] = middle_pos_x - AbstractCard.IMG_WIDTH_S * 2.1
	CARD_X_COORD_TABLE[6][1] = middle_pos_x - AbstractCard.IMG_WIDTH_S * 1.3
	CARD_X_COORD_TABLE[6][2] = middle_pos_x - AbstractCard.IMG_WIDTH_S * 0.43
	CARD_X_COORD_TABLE[6][3] = middle_pos_x + AbstractCard.IMG_WIDTH_S * 0.43
	CARD_X_COORD_TABLE[6][4] = middle_pos_x + AbstractCard.IMG_WIDTH_S * 1.3
	CARD_X_COORD_TABLE[6][5] = middle_pos_x + AbstractCard.IMG_WIDTH_S * 2.1

	# 7 card in hand
	CARD_X_COORD_TABLE[7][0] = middle_pos_x - AbstractCard.IMG_WIDTH_S * 2.4
	CARD_X_COORD_TABLE[7][1] = middle_pos_x - AbstractCard.IMG_WIDTH_S * 1.7
	CARD_X_COORD_TABLE[7][2] = middle_pos_x - AbstractCard.IMG_WIDTH_S * 0.9
	CARD_X_COORD_TABLE[7][3] = middle_pos_x
	CARD_X_COORD_TABLE[7][4] = middle_pos_x + AbstractCard.IMG_WIDTH_S * 0.9
	CARD_X_COORD_TABLE[7][5] = middle_pos_x + AbstractCard.IMG_WIDTH_S * 1.7
	CARD_X_COORD_TABLE[7][6] = middle_pos_x + AbstractCard.IMG_WIDTH_S * 2.4

	# 8 card in hand
	CARD_X_COORD_TABLE[8][0] = middle_pos_x - AbstractCard.IMG_WIDTH_S * 2.5
	CARD_X_COORD_TABLE[8][1] = middle_pos_x - AbstractCard.IMG_WIDTH_S * 1.82
	CARD_X_COORD_TABLE[8][2] = middle_pos_x - AbstractCard.IMG_WIDTH_S * 1.1
	CARD_X_COORD_TABLE[8][3] = middle_pos_x - AbstractCard.IMG_WIDTH_S * 0.38
	CARD_X_COORD_TABLE[8][4] = middle_pos_x + AbstractCard.IMG_WIDTH_S * 0.38
	CARD_X_COORD_TABLE[8][5] = middle_pos_x + AbstractCard.IMG_WIDTH_S * 1.1
	CARD_X_COORD_TABLE[8][6] = middle_pos_x + AbstractCard.IMG_WIDTH_S * 1.82
	CARD_X_COORD_TABLE[8][7] = middle_pos_x + AbstractCard.IMG_WIDTH_S * 2.5

	# 9 card in hand
	CARD_X_COORD_TABLE[9][0] = middle_pos_x - AbstractCard.IMG_WIDTH_S * 2.8
	CARD_X_COORD_TABLE[9][1] = middle_pos_x - AbstractCard.IMG_WIDTH_S * 2.2
	CARD_X_COORD_TABLE[9][2] = middle_pos_x - AbstractCard.IMG_WIDTH_S * 1.53
	CARD_X_COORD_TABLE[9][3] = middle_pos_x - AbstractCard.IMG_WIDTH_S * 0.8
	CARD_X_COORD_TABLE[9][4] = middle_pos_x
	CARD_X_COORD_TABLE[9][5] = middle_pos_x + AbstractCard.IMG_WIDTH_S * 0.8
	CARD_X_COORD_TABLE[9][6] = middle_pos_x + AbstractCard.IMG_WIDTH_S * 1.53
	CARD_X_COORD_TABLE[9][7] = middle_pos_x + AbstractCard.IMG_WIDTH_S * 2.2
	CARD_X_COORD_TABLE[9][8] = middle_pos_x + AbstractCard.IMG_WIDTH_S * 2.8