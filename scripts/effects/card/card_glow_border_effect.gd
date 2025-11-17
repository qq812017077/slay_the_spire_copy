class_name CardGlowBorderEffect
extends AbstractParticleEffect

@export var particle: GPUParticles2D = null
@export var process_material: ParticleProcessMaterial = null
var card_widget: CardWidget = null

func _ready() -> void:
    process_material = particle.process_material
#     sprite.texture = TextureHelper.get_cached_texture(ImageMaster.card_attack_bg_silhouette)
    particle.local_coords = true

func update_effect_position() -> void:
    particle.position = size / 2.0
    

func load(_card_widget: CardWidget, color:Color):
    card_widget = _card_widget

    match card_widget.card.type:
        AbstractCard.CardType.ATTACK:
            particle.texture = TextureHelper.get_cached_texture(ImageMaster.card_attack_bg_silhouette)
        AbstractCard.CardType.POWER:
            particle.texture = TextureHelper.get_cached_texture(ImageMaster.card_power_bg_silhouette)
        _:
            particle.texture = TextureHelper.get_cached_texture(ImageMaster.card_skill_bg_silhouette)

    particle.self_modulate = color

func set_particle_scale(scale_mount: float) -> void:
    # process_material.scale_min = scale_mount
    # process_material.scale_max = scale_mount
    scale = Vector2(scale_mount, scale_mount)

static func create(_card_widget: CardWidget, color:Color = Color.hex(0x30c8dcff)) -> CardGlowBorderEffect:
    var effect: CardGlowBorderEffect = CardGame.effect_library.card_glow_border_effect_prefab.instantiate()

    effect.load(_card_widget,color)
    return effect