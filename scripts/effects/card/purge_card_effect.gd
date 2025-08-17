class_name PurgeCardEffect extends AbstractGameEffect

const PADDING: float = 30.0
var card: AbstractCard = null
var card_widget: CardWidget = null
var damage_impact_particle_effect: DamageImpactCurvyParticleEffect = null

var card_scale
var scale_amount: float = 1.0
var scale_y: float = 1.0
var current_pos: Vector2
var target_pos: Vector2

var offset: Vector2
var rarity_color: Color = Color(1.0, 1.0, 1.0, 1.0)

var silhouette: Sprite2D = null
var silhouette_init_scale: Vector2
var card_shadow: Sprite2D = null
var card_shadow_2: Sprite2D = null
var card_shadow_init_scale: Vector2
func _init(_card: AbstractCard, card_pos: Vector2) -> void:
	card = _card
	duration = 2.0
	init_effect()
	scale_y = 1.0
	current_pos = card_pos
	update_color()
	
func _ready() -> void:
	card_widget = CardWidget.allocate(card, self)
	offset = card_widget.size * card_widget.scale * 0.5
	target_pos = identify_spawn_position()


	silhouette = Sprite2D.new()
	silhouette.texture = TextureHelper.get_cached_texture(ImageMaster.card_power_bg_silhouette)
	card_widget.add_child(silhouette)
	silhouette.position = offset
	silhouette_init_scale = Vector2(randf_range(0.95, 1.05), randf_range(0.95, 1.05))
	silhouette.modulate = color
	silhouette.name = "Silhouette"
	
	card_shadow_init_scale = Vector2(randf_range(0.95, 1.05), randf_range(0.95, 1.05))
	card_shadow = Sprite2D.new()
	card_shadow.texture = TextureHelper.get_cached_texture(ImageMaster.card_super_shadow)
	card_widget.add_child(card_shadow)
	card_shadow.position = offset
	card_shadow.modulate = rarity_color
	card_shadow.material = MaterialLibrary.add_material
	card_shadow.name = "CardShadow"
	
	card_shadow_2 = Sprite2D.new()
	card_shadow_2.texture = TextureHelper.get_cached_texture(ImageMaster.card_super_shadow)
	card_widget.add_child(card_shadow_2)
	card_shadow_2.position = offset
	card_shadow_2.modulate = rarity_color
	card_shadow_2.material = MaterialLibrary.add_material
	card_shadow_2.name = "CardShadow2"

	card_widget.modulate = Color.WHITE
	card_widget.scale = Vector2.ONE * 0.01
	name = "PurgeCardEffect"

	CardGame.sound.single_play("CARD_BURN")


func _process(delta: float) -> void:
	if is_done:
		return
	duration -= delta
	current_pos = MathHelper.vec2_lerp_snap(current_pos, target_pos, delta * 6.0)
	card_widget.position = current_pos - offset
	if duration < 0.5:
		card_widget.modulate.a -= delta * 2.0
		if damage_impact_particle_effect == null:
			# print("spawn damage impact particle effect")
			damage_impact_particle_effect = CardGame.effect_library.damage_impact_curvy_particle_effect_prefab.instantiate() as DamageImpactCurvyParticleEffect
			CardGame.dungeon_main_screen.add_particle_effect(damage_impact_particle_effect)
			damage_impact_particle_effect.position = current_pos
			damage_impact_particle_effect.play()
		else:
			damage_impact_particle_effect.update_particles_color(color, rarity_color)
		update_effect(delta)
	else:
		card_widget.scale = MathHelper.vec2_lerp_snap(card_widget.scale, Vector2.ONE, delta * 7.5)

	if duration <= 0:
		CardWidget.recycle(card_widget)
		card_widget = null
		is_done = true
		silhouette.queue_free()
		card_shadow.queue_free()
		card_shadow_2.queue_free()

func update_effect(delta: float) -> void:
	color.a = MathHelper.lerp_snap(color.a, 0.9, delta * 10.0)
	rarity_color.a = color.a
	scale_amount = CardGame.interpolation.apply_swing_out(1.6, 1.0, duration * 2.0)
	scale_y = CardGame.interpolation.apply_fade(0.005, 1.0, duration * 2.0)

	silhouette.modulate = color
	silhouette.scale = Vector2(scale_amount * silhouette_init_scale.x, scale_y * silhouette_init_scale.y)

	card_shadow.modulate = rarity_color
	card_shadow.scale = Vector2(scale_amount * card_shadow_init_scale.x, scale_y * card_shadow_init_scale.y) * 0.75
	card_shadow_2.modulate = rarity_color
	card_shadow_2.scale = Vector2(scale_amount * card_shadow_init_scale.x, scale_y * card_shadow_init_scale.y) * 0.5
func init_effect() -> void:
	pass

func identify_spawn_position() -> Vector2:
	var effect_count: int = 0

	var pos: Vector2 = Vector2(Settings.DEFAULT_WIDTH, Settings.DEFAULT_HEIGHT) * 0.5
	for game_effect in CardGame.dungeon_main_screen.game_effect_list:
		if game_effect is PurgeCardEffect and game_effect != self:
			effect_count += 1

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

func update_color() -> void:
	match card.rarity:
		AbstractCard.CardRarity.UNCOMMON:
			rarity_color = Color(0.2, 0.8, 0.8, 0.01)
		AbstractCard.CardRarity.RARE:
			rarity_color = Color(0.8, 0.7, 0.2, 0.01)
		_:
			rarity_color = Color(0.6, 0.6, 0.6, 0.01)

	match card.color:
		AbstractCard.CardColor.RED:
			color = Color(0.9, 0.3, 0.2, 0.01)
		AbstractCard.CardColor.GREEN:
			color = Color(0.2, 0.7, 0.2, 0.01)
		AbstractCard.CardColor.BLUE:
			color = Color(0.1, 0.4, 0.7, 0.01)
		AbstractCard.CardColor.COLORLESS:
			color = Color(0.4, 0.4, 0.4, 0.01)
		_:
			color = Color(0.2, 0.15, 0.2, 0.01)
