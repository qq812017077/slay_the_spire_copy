class_name OverlayMenu
extends Control

@export var black_mask: Control = null
@export var cancel_button: ScreenButton
@export var confirm_button: ScreenButton
@export var proceed_button: ProceedButton
@export var dynamic_banner: DynamicBanner = null

var target_black_alpha: float = 0.
var tween: Tween = null
func _ready() -> void:
	black_mask.z_index = Global.OVERLAY_BLACK_Z_INDEX
	black_mask.modulate = Color(0, 0, 0, 0)
	# await get_tree().create_timer(1).timeout
	# proceed_button.show_button()
	if dynamic_banner == null:
		dynamic_banner = DynamicBanner.new()
		add_child(dynamic_banner)
		dynamic_banner.hide_banner(true)
# func _process(delta: float) -> void:
#     if target_black_alpha != black_mask.modulate.a:
#         if target_black_alpha > black_mask.modulate.a:
#             black_mask.modulate.a += delta * 2
#             black_mask.modulate.a = min(black_mask.modulate.a, target_black_alpha)
#         elif target_black_alpha < black_mask.modulate.a:
#             black_mask.modulate.a -= delta * 2
#             black_mask.modulate.a = max(black_mask.modulate.a, target_black_alpha)

func show_black(instant: bool = false, alpha: float = 0.8) -> void:
	if tween != null:
		tween.stop()
	if instant:
		black_mask.modulate = Color(0, 0, 0, alpha)
		return
	tween = create_tween()
	tween.tween_property(black_mask, "modulate", Color(0, 0, 0, alpha), 0.5)

func hide_black(instant: bool = false) -> void:
	if tween != null:
		tween.stop()
	if instant:
		black_mask.modulate = Color(0, 0, 0, 0.0)
		return
	tween = create_tween()
	tween.tween_property(black_mask, "modulate", Color(0, 0, 0, 0), 0.5)

func hide_black_during(during_time: float) -> void:
	if tween != null:
		tween.stop()
	during_time = max(during_time, 0.1)
	tween = create_tween()
	tween.tween_property(black_mask, "modulate", Color(0, 0, 0, 0), during_time)

func reshow_cancel_button() -> void:
	cancel_button.hide_button(true)
	cancel_button.show_button()

