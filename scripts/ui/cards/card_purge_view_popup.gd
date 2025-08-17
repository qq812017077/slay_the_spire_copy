class_name CardPurgeViewPopup
extends Control


@export var black_bg: Control = null


@export_group("Cards")
@export var hovered_card_container: Control = null
@export_group("")


var hovered_cardwidget: CardWidget = null
func _ready() -> void:
	black_bg.self_modulate = Color(0, 0, 0, 0)

func _process(delta: float) -> void:
	if not visible:
		return
	black_bg.self_modulate.a = MathHelper.lerp_snap(black_bg.self_modulate.a, 0.8, delta * 10)

func open(card: AbstractCard) -> void:
	visible = true
	if hovered_cardwidget == null:
		hovered_cardwidget = CardWidget.allocate(card, hovered_card_container)
	else:
		hovered_cardwidget.load_card(card)

func close() -> void:
	visible = false
	CardWidget.recycle(hovered_cardwidget)
	hovered_cardwidget = null
	black_bg.self_modulate.a = 0