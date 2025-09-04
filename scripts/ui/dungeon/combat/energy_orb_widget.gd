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
var is_loaded = false

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
func _process(delta: float) -> void:
    if not is_loaded:
        return 
    
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
    
    update_orb.call()
    
func load_player(_player: AbstractPlayer) -> void:
    player = _player
    match player.type:
        AbstractPlayer.PlayerType.IRONCLAD:
            update_orb = update_orb_red
            energy_layer1 = ImageMaster.energy_red_layer1
            energy_layer2 = ImageMaster.energy_red_layer2
            energy_layer3 = ImageMaster.energy_red_layer3
            energy_layer4 = ImageMaster.energy_red_layer4
            energy_layer5 = ImageMaster.energy_red_layer5
            energy_layer6 = ImageMaster.energy_red_layer6
            energy_layer1d = ImageMaster.energy_red_layer1D
            energy_layer2d = ImageMaster.energy_red_layer2D
            energy_layer3d = ImageMaster.energy_red_layer3D
            energy_layer4d = ImageMaster.energy_red_layer4D
            energy_layer5d = ImageMaster.energy_red_layer5D

            move_child(layer1,0)
            move_child(layer1,1)
            move_child(layer1,2)
            move_child(layer1,3)
            move_child(layer1,4)
            move_child(layer1,5)
        AbstractPlayer.PlayerType.THE_SILENT:
            energy_layer1 = ImageMaster.energy_green_layer1
            energy_layer2 = ImageMaster.energy_green_layer2
            energy_layer3 = ImageMaster.energy_green_layer3
            energy_layer4 = ImageMaster.energy_green_layer4
            energy_layer5 = ImageMaster.energy_green_layer5
            energy_layer6 = ImageMaster.energy_green_layer6
            energy_layer1d = ImageMaster.energy_green_layer1D
            energy_layer2d = ImageMaster.energy_green_layer2D
            energy_layer3d = ImageMaster.energy_green_layer3D
            energy_layer4d = ImageMaster.energy_green_layer4D
            energy_layer5d = ImageMaster.energy_green_layer5D
        AbstractPlayer.PlayerType.DEFECT:
            energy_layer1 = ImageMaster.energy_blue_layer1
            energy_layer2 = ImageMaster.energy_blue_layer2
            energy_layer3 = ImageMaster.energy_blue_layer3
            energy_layer4 = ImageMaster.energy_blue_layer4
            energy_layer5 = ImageMaster.energy_blue_layer5
            energy_layer6 = ImageMaster.energy_blue_layer6
            energy_layer1d = ImageMaster.energy_blue_layer1D
            energy_layer2d = ImageMaster.energy_blue_layer2D
            energy_layer3d = ImageMaster.energy_blue_layer3D
            energy_layer4d = ImageMaster.energy_blue_layer4D
            energy_layer5d = ImageMaster.energy_blue_layer5D
        AbstractPlayer.PlayerType.WATCHER:
            pass

    is_loaded = true

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

func update_orb_red():
    layer1.rotation_degrees = angle_l1
    layer2.rotation_degrees = angle_l2
    layer3.rotation_degrees = angle_l3
    layer4.rotation_degrees = angle_l4
    layer5.rotation_degrees = angle_l5

func update_orb_green():
    layer1.rotation_degrees = angle_l1
    layer2.rotation_degrees = angle_l2
    layer3.rotation_degrees = angle_l3
    layer4.rotation_degrees = angle_l4
    layer5.rotation_degrees = angle_l5

func update_orb_blue():
    layer1.rotation_degrees = angle_l1
    layer2.rotation_degrees = angle_l2
    layer3.rotation_degrees = angle_l3
    layer4.rotation_degrees = angle_l4
    layer5.rotation_degrees = angle_l5

func update_orb_purple():
    layer1.rotation_degrees = angle_l1
    layer2.rotation_degrees = angle_l2
    layer3.rotation_degrees = angle_l3
    layer4.rotation_degrees = angle_l4
    layer5.rotation_degrees = angle_l5