class_name DungeonRoomScreen
extends Control

@export var scene_container: Control = null

var dungeon: AbstractDungeons = null
var cur_room: AbstractRoom = null
var player: AbstractPlayer = null
var monsters: Array[AbstractMonster] = []


func _ready() -> void:
    pass

func load_dungeon(_dungeon: AbstractDungeons) -> void:
    dungeon = _dungeon

func load_room(_room: AbstractRoom) -> void:
    cur_room = _room


func render_combat_room() -> void:
    pass

func render_event_room() -> void:
    pass

func render_compfire_room() -> void:
    pass