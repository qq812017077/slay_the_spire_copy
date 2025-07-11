class_name MainMenuButton
extends Button

enum ClickResult {PLAY, RESUME_GAME, ABANDON_RUN, INFO, STAT, SETTINGS, PATCH_NOTES, QUIT}
static var highlight_img :Texture2D = null
static var canvas_material: CanvasItemMaterial = null

@export var click_result: ClickResult = ClickResult.PLAY
var targetX_offset: float = 0
var x_offset: float = 0
var highlight_tex: TextureRect = null
var highlight_alpha: float = 0
static func initialize() -> void:
	highlight_img = load("res://arts/slay_the_spire/images/ui/menu/menu_option_highlight.png")
	canvas_material = CanvasItemMaterial.new()
	canvas_material.blend_mode = CanvasItemMaterial.BLEND_MODE_ADD
	
func _ready() -> void:
	var texs : Array[Node] = find_children("*", "TextureRect")
	if texs.size() == 0:
		highlight_tex = TextureRect.new()
		add_child(highlight_tex)
	else:
		if texs.size() > 1:
			for i in range(1, texs.size()):
				texs[i].queue_free()
		highlight_tex = texs[0]
	
	highlight_tex.material = canvas_material
	ThemeHelper.apply_menu_button_style(self, true)
	highlight_tex.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
	highlight_tex.mouse_filter = Control.MOUSE_FILTER_IGNORE
	highlight_tex.set_anchors_preset(LayoutPreset.PRESET_CENTER_LEFT)
	highlight_tex.z_index = -1
	highlight_tex.texture = highlight_img

	await get_tree().process_frame
	highlight_tex.size = Vector2(highlight_img.get_size().x, size.y * 1.8)

	highlight_tex.position = highlight_tex.position - Vector2(30, (highlight_tex.size.y - size.y) / 2)
	
