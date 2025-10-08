class_name MaterialLibrary
extends Object


static var shadow_material: ShaderMaterial = null
static var add_material: CanvasItemMaterial = null
static var gray_material: ShaderMaterial = null
static func initialize() -> void:
    shadow_material = ShaderMaterial.new()
    shadow_material.shader = load("res://shaders/shadow.gdshader")
    gray_material = ShaderMaterial.new()
    gray_material.shader = load("res://shaders/gray.gdshader")
    add_material = CanvasItemMaterial.new()
    add_material.blend_mode = CanvasItemMaterial.BlendMode.BLEND_MODE_ADD