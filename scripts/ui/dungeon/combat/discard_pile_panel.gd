class_name DiscardPilePanel
extends AbstractPanel


static var ui_string: UIString = null
static var TEXT: Array = []

@export var discard_sprite: Sprite2D = null
@export var turn_num_label: Label = null
var scale_amount: float = 1.0
var turn_num_size: int = -1

var discard_btn: Button = null

func _ready() -> void:
	if ui_string == null:
		ui_string = CardGame.languagePack.get_ui_string("DiscardPilePanel")
		TEXT = ui_string.TEXT
	

	discard_btn = ButtonHelper.create_fit_button_from_sprite(discard_sprite)
	ThemeHelper.apply_label_font_style_with_settings(turn_num_label, ThemeHelper.turn_font_label_settings, Color.WHITE)

	
func update(delta: float) -> void:
	update_vfx(delta)
	update_pop(delta)



func update_vfx(delta: float) -> void:
	pass

func update_pop(delta: float) -> void:
	scale_amount = MathHelper.lerp_snap(scale_amount, 1.0, delta * 8.0)

	
	if discard_btn.is_hovered():
		scale_amount = 1.2
	
	discard_sprite.scale = Vector2(scale_amount, scale_amount)

func pop() -> void:
	scale_amount = 1.75

func update_discard_pile(pile_size: int) -> void:
	if turn_num_size == pile_size:
		return
	turn_num_size = pile_size
	turn_num_label.text = str(turn_num_size)
	turn_num_label.position = - turn_num_label.get_size() / 2


func on_combat_start() -> void:
	pass