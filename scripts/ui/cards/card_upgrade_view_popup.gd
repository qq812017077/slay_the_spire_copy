class_name CardUpgradeViewPopup
extends Control


@export var black_bg: Control = null
@export_group("Arrows")
@export var arrow_container: Control = null
@export_group("")
@export_group("Cards")
@export var hovered_card_container: Control = null
@export var upgraded_preview_card_container: Control = null
@export_group("")
var arrows: Array[Sprite2D] = []
var scale_timer: float = 0.0

var hovered_cardwidget: CardWidget = null
var upgraded_preview_cardwidget: CardWidget = null

func _ready() -> void:
	for child in arrow_container.get_children():
		if child is Sprite2D:
			arrows.append(child)
	
	black_bg.self_modulate = Color(0, 0, 0, 0)

func _process(delta: float) -> void:
	if not visible:
		return
	black_bg.self_modulate.a = MathHelper.lerp_snap(black_bg.self_modulate.a, 0.8, delta * 10)
	update_arrows(delta)

func open(card: AbstractCard) -> void:
	visible = true
	if hovered_cardwidget == null:
		hovered_cardwidget = CardWidget.allocate(card, hovered_card_container)
	else:
		hovered_cardwidget.load_card(card)
	
	if upgraded_preview_cardwidget == null:
		upgraded_preview_cardwidget = CardWidget.allocate(card, upgraded_preview_card_container)
	else:
		upgraded_preview_cardwidget.load_card(card)
	
	upgraded_preview_cardwidget.display_in_library(true, true)

func close() -> void:
	visible = false
	CardWidget.recycle(hovered_cardwidget)
	CardWidget.recycle(upgraded_preview_cardwidget)
	hovered_cardwidget = null
	upgraded_preview_cardwidget = null
	black_bg.self_modulate.a = 0

func update_arrows(delta: float) -> void:
	scale_timer += delta * 5.0
	for i in range(arrows.size()):
		var arrow: Sprite2D = arrows[i]
		arrow.scale = Vector2.ONE * (0.8 + (cos(scale_timer - i * 0.8) + 1.0) * 0.2)
