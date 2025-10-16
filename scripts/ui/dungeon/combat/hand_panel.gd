class_name HandPanel
extends AbstractPanel

const HOVER_CARD_POS: float = Settings.DEFAULT_HEIGHT - 50.0
var CARD_X_COORD_TABLE: Dictionary = {}
var CARD_Y_OFFSET_TABLE: Dictionary = {}


var hand_card_widgets: Array[CardWidget] = []
var hovered_card: CardWidget = null
var is_hovering_card: bool = false
func _ready() -> void:
	build_pos_table()

func update(delta: float) -> void:
	var cur_hovered_card: CardWidget = null
	var cur_hovering_card: bool = false
	for card in hand_card_widgets:
		card.update_position(delta)
		card.update_angle(delta)
		card.update_scale(delta)

		if card.is_hovering():
			card.z_index = 1
		else:
			card.z_index = 0
		if not cur_hovering_card and card.is_hovering():
			cur_hovered_card = card
			cur_hovering_card = true
	
	var changed:bool = cur_hovering_card != is_hovering_card or cur_hovered_card != hovered_card

	if changed:
		refresh_layout()
		if cur_hovering_card:
			cur_hovered_card.set_target_pos_y(HOVER_CARD_POS- cur_hovered_card.size.y, true)
			cur_hovered_card.set_target_angle(0.0, true)
			cur_hovered_card.set_target_scale(1.3333, true)
			hover_card_push(cur_hovered_card)
	
	
	hovered_card = cur_hovered_card
	is_hovering_card = cur_hovering_card

func add_to_hand(card: CardWidget) -> void:
	hand_card_widgets.append(card)

func on_combat_start() -> void:
	for widget: CardWidget in hand_card_widgets:
		CardWidget.recycle(widget)
	
	hand_card_widgets.clear()

func hover_card_push(card: CardWidget) -> void:
	var hand_card_count: int = hand_card_widgets.size()
	if hand_card_count < 2:
		return
	
	var card_num: int = -1
	for i: int in range(hand_card_count):
		if hand_card_widgets[i] == card:
			card_num = i
			break
	
	var push_amt: float = 0.4
	if hand_card_count == 2:
		push_amt = 0.2
	elif hand_card_count == 3 or hand_card_count == 4:
		push_amt = 0.27
	
	var left_push_amt: float = push_amt
	var right_push_amt: float = push_amt

	var right_slot: int = card_num + 1
	var left_slot: int = card_num - 1
	while right_slot < hand_card_count:
		hand_card_widgets[right_slot].target_pos.x += AbstractCard.IMG_WIDTH_S * right_push_amt
		right_push_amt *= 0.25
		right_slot += 1
	
	while left_slot >= 0 and left_slot < hand_card_count:
		hand_card_widgets[left_slot].target_pos.x -= AbstractCard.IMG_WIDTH_S * left_push_amt
		left_push_amt *= 0.25
		left_slot -= 1

func refresh_layout() -> void:
	
	for relic : AbstractRelic in player.relics:
		relic.on_refresh_hand()
	
	var hand_group_size: int = player.hand.group.size()
	var angle_range : float= 50.0 - ( 10 - hand_group_size) * 5.0
	var increment_angle : float = angle_range / hand_group_size
	var sink_start : float = 80.0
	var sink_range : float = 300.0
	var increment_sink: float = sink_range / hand_group_size / 2.0
	var middle : int = int(hand_group_size / 2.0)

	var even_count: bool = hand_group_size % 2 == 0
	for i: int in range(hand_group_size):
		hand_card_widgets[i].set_target_angle(increment_angle * i + increment_angle / 2.0 - angle_range / 2.0)
		hand_card_widgets[i].set_target_scale(1.0)
		var t: int = i - middle
		
		if t >= 0:
			if even_count:
				t += 1
			t = -t
		
		if even_count:
			t += 1
		t = int(t * 1.7)

		var target_y : float =Settings.DEFAULT_HEIGHT - sink_start - increment_sink * t
		hand_card_widgets[i].set_target_pos(Vector2(CARD_X_COORD_TABLE[hand_group_size][i], target_y) - hand_card_widgets[i].pivot_offset)

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
	for i in range(1, 11):
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
	
	# 10 card in hand
	CARD_X_COORD_TABLE[10][0] = middle_pos_x - AbstractCard.IMG_WIDTH_S * 2.9
	CARD_X_COORD_TABLE[10][1] = middle_pos_x - AbstractCard.IMG_WIDTH_S * 2.4
	CARD_X_COORD_TABLE[10][2] = middle_pos_x - AbstractCard.IMG_WIDTH_S * 1.8
	CARD_X_COORD_TABLE[10][3] = middle_pos_x - AbstractCard.IMG_WIDTH_S * 1.1
	CARD_X_COORD_TABLE[10][4] = middle_pos_x - AbstractCard.IMG_WIDTH_S * 0.4
	CARD_X_COORD_TABLE[10][5] = middle_pos_x + AbstractCard.IMG_WIDTH_S * 0.4
	CARD_X_COORD_TABLE[10][6] = middle_pos_x + AbstractCard.IMG_WIDTH_S * 1.1
	CARD_X_COORD_TABLE[10][7] = middle_pos_x + AbstractCard.IMG_WIDTH_S * 1.8
	CARD_X_COORD_TABLE[10][8] = middle_pos_x + AbstractCard.IMG_WIDTH_S * 2.4
	CARD_X_COORD_TABLE[10][9] = middle_pos_x + AbstractCard.IMG_WIDTH_S * 2.9
