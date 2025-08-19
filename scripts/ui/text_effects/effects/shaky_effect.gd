@tool
class_name ShakyEffect
extends RichTextEffect

const SHAKE_AMT: float = 2.0
var bbcode := "shaky"
var init_sec_time: float = 0.0

func _init() -> void:
	init_sec_time = Time.get_ticks_msec() / 1000.0
	
func _process_custom_fx(char_fx: CharFXTransform) -> bool:
	
	# print("char_fx.elapsed_time:",char_fx.elapsed_time)
	# if char_fx.elapsed_time >= 10:
	# 	char_fx.offset.x = randf_range(-SHAKE_AMT, SHAKE_AMT)
	# 	char_fx.offset.y = randf_range(-SHAKE_AMT, SHAKE_AMT)
	# 	char_fx.elapsed_time = 0.0
	
	return false