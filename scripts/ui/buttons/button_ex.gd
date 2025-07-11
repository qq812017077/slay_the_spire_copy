#
#	不使用button自己的文本系统，改为添加一个子label，进而实现更加完善的控制
#
class_name ButtonEx
extends Button

@export_group("Button Color")
@export var button_normal_color: Color = Color.WHITE
@export var button_hover_color: Color = Color.WHITE
@export_group("")

@export_group("Label Color")
@export var label_normal_color: Color = Color.WHITE
@export var label_hover_color: Color = Color.WHITE
@export_group("")

@export_group("Texture Color")
@export var texture :  Sprite2D = null
@export var texture_normal_color: Color = Color.WHITE
@export var texture_hover_color: Color = Color.WHITE
@export_group("")
var label: Label = null



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	label = Label.new()
	add_child(label)
	label.set_anchors_preset(PRESET_FULL_RECT, true)
	label.horizontal_alignment = self.alignment
	label.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
	text = ""

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if is_hovered() or button_pressed:
		modulate = button_hover_color
		label.self_modulate = label_hover_color
		if texture:
			texture.self_modulate = texture_hover_color
	else:
		modulate = button_normal_color
		label.self_modulate = label_normal_color
		if texture:
			texture.self_modulate = texture_normal_color


func set_label(_text: String) -> void:
	label.text = _text
