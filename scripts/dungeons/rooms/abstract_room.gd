class_name AbstractRoom
extends Object

enum RoomPhase {COMBAT, EVENT, COMPLETE, INCOMPLETE, NONE}
enum RoomType {REST, SHOP, MONSTER, SHRINE, TREASURE, EVENT, ELITE, BOSS, NEOW}

static var ui_string: UIString
static var TEXT: Array

var phase: RoomPhase
var type: RoomType

var map_symbol: String
var map_img: Texture2D
var map_img_outline: Texture2D

func _init(_phase: RoomPhase, symbol: String, img: Texture2D, img_outline: Texture2D) -> void:
    phase = _phase
    map_symbol = symbol
    map_img = img
    map_img_outline = img_outline
    set_type_by_symbol(symbol)

func set_type_by_symbol(symbol: String) -> void:
    if symbol == "R":
        type = RoomType.REST
    elif symbol == "$":
        type = RoomType.SHOP
    elif symbol == "M":
        type = RoomType.MONSTER
    elif symbol == "H":
        type = RoomType.SHRINE
    elif symbol == "T":
        type = RoomType.TREASURE
    elif symbol == "E":
        type = RoomType.EVENT
    elif symbol == "L":
        type = RoomType.ELITE
    elif symbol == "B":
        type = RoomType.BOSS
    elif symbol == "N":
        type = RoomType.NEOW
    else:
        push_error(("Invalid room symbol: {0}").format([symbol]))


func on_player_entry():
    pass