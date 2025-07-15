class_name TipMaster
extends Control

const RENDERING_TIP_WAIT_TIME = 0.2
const OFFSET_Y = 10
const OFFSET_X = 5
var card_tip_pool: Array[CardTip]
var tooltip_prefab: PackedScene = null

var cardwidget: CardWidget = null
var cardtips: Array[CardTip] = []

var preview_container: Control = null
var preview: CardWidget = null

var rendering_wait_timer = 0
var thread: Thread = null
var last_frame: int = 2

var generic_keyword: String = ""
var generic_tip: CardTip = null
var generic_draw_pos: Vector2 = Vector2(0, 0)
func _ready() -> void:
	tooltip_prefab = load("res://scenes/slay_the_spire/cards/card_tip.tscn")

	preview_container = Control.new()
	add_child(preview_container)
	preview_container.name = "Preview Container"

	await get_tree().process_frame
	preview_container.scale = Vector2(0.765, 0.765) * Settings.scale
	preview_container.z_index = Global.TIP_Z_INDEX
func _exit_tree() -> void:
	if thread != null:
		thread.wait_to_finish()

func _process(delta: float) -> void:
	if last_frame < 0:
		return
	
	update_generic_tip(delta)
	update_card_tip(delta)
	
	last_frame -= 1
	if last_frame <= 0:
		remove_tip_rendering()

func update_generic_tip(delta: float) -> void:
	if generic_tip == null:
		return

	generic_tip.position = generic_draw_pos
	if generic_tip.rendering_finished:
		if rendering_wait_timer > 0:
			rendering_wait_timer -= delta
		if rendering_wait_timer <= 0:
			generic_tip.visible = true

func update_card_tip(delta: float) -> void:
	if cardwidget == null:
		return
	var preview_left: bool = true
	# 依据卡牌的位置对tooltip进行渲染
	var card_widget_rect: Rect2 = cardwidget.get_global_rect()
	var preview_pos_x: float = 0
	var tip_y = card_widget_rect.position.y
	for tip in cardtips:
		var tip_rect = tip.get_global_rect()
		if card_widget_rect.position.x + card_widget_rect.size.x + tip_rect.size.x + OFFSET_X > Settings.WIDTH:
			tip.position.x = card_widget_rect.position.x - tip_rect.size.x - OFFSET_X
			preview_left = false
		else:
			tip.position.x = card_widget_rect.position.x + card_widget_rect.size.x + OFFSET_X
		tip.position.y = tip_y
		tip_y += tip.get_global_rect().size.y + OFFSET_Y * Settings.scale
	
	if preview:
		var preview_rect = preview.get_global_rect()
		if preview_left:
			preview_pos_x = card_widget_rect.position.x - preview_rect.size.x - OFFSET_X * 5
		else:
			preview_pos_x = card_widget_rect.position.x + card_widget_rect.size.x + OFFSET_X * 5
		
		preview.global_position.x = preview_pos_x
		preview.global_position.y = card_widget_rect.position.y

	var finished = true
	for tip in cardtips:
		if not tip.rendering_finished:
			finished = false
			break
	if finished:
		if rendering_wait_timer > 0:
			rendering_wait_timer -= delta
			if rendering_wait_timer <= 0:
				for tip in cardtips:
					tip.visible = true
				if preview:
					preview.visible = true

func render_generic_tip(pos: Vector2, keyword: String, body: String) -> void:
	if generic_keyword == keyword:
		last_frame = 2
		return
	
	if generic_tip != null:
		generic_tip.clear_content()
		recycle_tooltip(generic_tip)
		generic_tip = null
	generic_keyword = keyword
	last_frame = 2
	rendering_wait_timer = RENDERING_TIP_WAIT_TIME
	var tooltip: CardTip = get_idle_tooltip()
	tooltip.rendering_front()
	tooltip.set_content(generic_keyword, body)
	tooltip.visible = false
	generic_tip = tooltip
	generic_draw_pos = pos

func render_tip_for_card(_cardwidget: CardWidget, safe_thread: bool = false) -> void:
	if cardwidget == _cardwidget:
		last_frame = 2
		return
	if cardwidget != null:
		for tip in cardtips:
			recycle_tooltip(tip)
		cardwidget = null
		cardtips = []
		preview = null
	
	var card = _cardwidget.upgraded_card_library if _cardwidget.upgraded_card_library != null else _cardwidget.card
	if card.keywords.size() == 0 and card.card_to_preview == null:
		return
	
	last_frame = 2
	cardwidget = _cardwidget
	rendering_wait_timer = RENDERING_TIP_WAIT_TIME
	cardtips = []

	if safe_thread:
		thread = Thread.new()
		if not thread.is_started():
			thread.start(thread_create_tooltips)
	else:
		thread = null
		
		for keyword in card.keywords:
			if not GameDictionary.keywords.has(keyword):
				continue
			var tooltip: CardTip = get_idle_tooltip()
			tooltip.rendering_front()
			tooltip.set_content(keyword, GameDictionary.keywords[keyword])
			tooltip.visible = false
			cardtips.append(tooltip)
		if card.card_to_preview:
			preview = CardWidget.allocate_by_type(card.card_to_preview.type)
			preview_container.add_child(preview)
			preview.visible = false
			preview.load_card(card.card_to_preview)

func thread_create_tooltips() -> void:
	var card = cardwidget.upgraded_card_library if cardwidget.upgraded_card_library else cardwidget.card
	for keyword in card.keywords:
		if not GameDictionary.keywords.has(keyword):
			continue
		var tooltip: CardTip = get_idle_tooltip()
		tooltip.safe_set_content(keyword, GameDictionary.keywords[keyword])
		tooltip.rendering_front.call_deferred()
		tooltip.visible = false
		cardtips.append(tooltip)

func remove_tip_rendering() -> void:
	if thread != null:
		thread.wait_to_finish()
	
	generic_keyword = ""
	rendering_wait_timer = RENDERING_TIP_WAIT_TIME

	# remove all tooltips
	for tip in cardtips:
		tip.clear_content()
		recycle_tooltip(tip)
	cardwidget = null
	cardtips = []

	if generic_tip:
		generic_tip.clear_content()
		recycle_tooltip(generic_tip)
		generic_tip = null

	if preview != null:
		CardWidget.recycle(preview)
		preview = null

func get_idle_tooltip() -> CardTip:
	# push_error("get tooltip")
	var cardtip: CardTip
	if card_tip_pool.size() > 0:
		cardtip = card_tip_pool.pop_front()
	else:
		cardtip = tooltip_prefab.instantiate()
	add_child(cardtip)
	return cardtip

func recycle_tooltip(cardtip: CardTip) -> void:
	card_tip_pool.append(cardtip)
	if cardtip.get_parent():
		cardtip.get_parent().remove_child(cardtip)
	cardtip.visible = false
