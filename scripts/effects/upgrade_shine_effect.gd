class_name UpgradeShineEffect
extends AbstractGameEffect


var pos: Vector2
var clang1: bool = false
var clang2: bool = false


func _init(_pos: Vector2) -> void:
	pos = _pos

func _ready() -> void:
	duration = 0.8
	name="UpgradeShineEffect"

func _process(delta: float) -> void:
	duration -= delta
	if is_done:
		return

	if duration < 0.6 and not self.clang1:
		CardGame.sound.single_play("CARD_UPGRADE")
		clang1 = true
		clank(pos - Vector2(80, 0))
		CardGame.screen_shake.shake(ScreenShake.ShakeIntensity.HIGH, ScreenShake.ShakeDur.SHORT, false)

	if duration < 0.2 and not self.clang2:
		clang2 = true
		clank(pos + Vector2(90, -110))
		CardGame.screen_shake.shake(ScreenShake.ShakeIntensity.HIGH, ScreenShake.ShakeDur.SHORT, false)

	if duration < 0.0 and not self.is_done:
		is_done = true
		clank(pos + Vector2(30, 120))
		CardGame.screen_shake.shake(ScreenShake.ShakeIntensity.HIGH, ScreenShake.ShakeDur.SHORT, false)

func clank(effect_pos: Vector2) -> void:
	# effect display
	var upgrade_hammer_imprint_effect = CardGame.effect_library.upgrade_hammer_impact_effect_prefab.instantiate() as UpgradeHammerImprintEffect
	CardGame.dungeon_main_screen.add_game_effect(upgrade_hammer_imprint_effect)
	upgrade_hammer_imprint_effect.position = effect_pos

	var upgrade_shine_particle_effect = CardGame.effect_library.upgrade_shine_particle_effect_prefab.instantiate() as UpgradeShineParticleEffect
	CardGame.dungeon_main_screen.add_particle_effect(upgrade_shine_particle_effect)
	upgrade_shine_particle_effect.position = effect_pos
