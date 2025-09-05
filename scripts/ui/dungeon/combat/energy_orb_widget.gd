class_name EnergyOrbWidget
extends Control

@export var cur_orb_count : int = 3
@export var layer1: Sprite2D = null
@export var layer2: Sprite2D = null
@export var layer3: Sprite2D = null
@export var layer4: Sprite2D = null
@export var layer5: Sprite2D = null
@export var layer6: Sprite2D = null
var player: AbstractPlayer = null

var update_orb: Callable

var energy_layer1: Texture2D = null
var energy_layer2: Texture2D = null
var energy_layer3: Texture2D = null
var energy_layer4: Texture2D = null
var energy_layer5: Texture2D = null
var energy_layer6: Texture2D = null
var energy_layer1d: Texture2D = null
var energy_layer2d: Texture2D = null
var energy_layer3d: Texture2D = null
var energy_layer4d: Texture2D = null
var energy_layer5d: Texture2D = null
var angle_l1: float = 0.0
var angle_l2: float = 0.0
var angle_l3: float = 0.0
var angle_l4: float = 0.0
var angle_l5: float = 0.0

var enabled: bool = false

func update(delta: float) -> void:
	
	if cur_orb_count == 0:
		angle_l1 += delta * 72.0
		angle_l2 += delta * 8.0
		angle_l3 += delta * -8.0
		angle_l4 += delta * 5.0
		angle_l5 += delta * -5.0
	else:
		angle_l1 += delta * 360.0
		angle_l2 += delta * 40.0
		angle_l3 += delta * -40.0
		angle_l4 += delta * 20.0
		angle_l5 += delta * -20.0
	
	update_orb.call(self)
	
func enable():
	enabled = true
	layer1.texture = energy_layer1
	layer2.texture = energy_layer2
	layer3.texture = energy_layer3
	layer4.texture = energy_layer4
	layer5.texture = energy_layer5
	layer6.texture = energy_layer6


func disable():
	enabled = false
	layer1.texture = energy_layer1d
	layer2.texture = energy_layer2d
	layer3.texture = energy_layer3d
	layer4.texture = energy_layer4d
	layer5.texture = energy_layer5d
	layer6.texture = energy_layer6
