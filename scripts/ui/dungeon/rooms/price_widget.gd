class_name PriceWidget extends Control

@export var price: Label
var target: Control = null
var priceAmt: int = 0
func _ready() -> void:
	ThemeHelper.apply_label_font_style_with_settings(price, ThemeHelper.tip_header_label_settings, Color.WHITE)

func bind(_target: Control) -> void:
	self.target = _target
	name = _target.name + "_price"

func _process(_delta: float) -> void:
	var rect: Rect2 = target.get_global_rect()
	global_position = rect.position + Vector2((rect.size.x - size.x) / 2, rect.size.y)

func update_price(_priceAmt: int) -> void:
	priceAmt = max(0, _priceAmt)
	self.price.text = str(priceAmt)

func refresh_price_color(has_sale_tag: bool = false) -> void:
	if CardGame.dungeon_main_screen.player.gold < priceAmt:
		price.modulate = Color.SALMON
	elif has_sale_tag:
		price.modulate = Color.LIGHT_SKY_BLUE
	else:
		price.modulate = Color.WHITE
