class_name ShowCardBrieflyEffect
extends AbstractGameEffect

const PADDING: float = 30.0
var card: AbstractCard

var cur_scale: float = 0.01
var target_pos: Vector2
var card_widget: CardWidget = null

var scale_y: float
var rarity_color: Color

func _init(_card: AbstractCard) -> void:
	card = _card
	duration = 2.0
	starting_duration = duration
	cur_scale = 0.01
	
func _ready() -> void:
	card_widget = CardWidget.allocate(card, self)
	
	card_widget.position = identify_spawn_position() - card_widget.size * card_widget.scale * 0.5
	card_widget.modulate = Color.WHITE

	name = "ShowCardBrieflyEffect"
func _process(delta: float) -> void:
	if is_done:
		return
	duration -= delta

	cur_scale = MathHelper.lerp_snap(cur_scale, 1.0, delta * 7.5)
	
	card_widget.scale = Vector2.ONE * cur_scale
	if duration < 0.6:
		card_widget.modulate.a -= delta * 2.0
	
	if duration <= 0 and card_widget.modulate.a <= 0.0:
		CardWidget.recycle(card_widget)
		card_widget = null
		is_done = true

func identify_spawn_position() -> Vector2:
	var effect_count: int = 0

	var pos: Vector2 = Vector2(Settings.DEFAULT_WIDTH, Settings.DEFAULT_HEIGHT) * 0.5
	for game_effect in CardGame.dungeon_main_screen.game_effect_list:
		if game_effect is ShowCardBrieflyEffect and game_effect != self:
			effect_count += 1
	
	print("effect_count: ", effect_count)
	if effect_count < 5:
		if effect_count % 2 == 1:
			pos.x -= (PADDING + AbstractCard.IMG_WIDTH) * ((effect_count + 1) * 0.5)
		elif effect_count % 2 == 0:
			pos.x += (PADDING + AbstractCard.IMG_WIDTH) * (effect_count * 0.5)
	else:
		pos.x = randf_range(Settings.DEFAULT_WIDTH * 0.1, Settings.DEFAULT_WIDTH * 0.9)
		pos.y = randf_range(Settings.DEFAULT_HEIGHT * 0.2, Settings.DEFAULT_HEIGHT * 0.8)

	print("spawn position: ", pos)
	return pos
