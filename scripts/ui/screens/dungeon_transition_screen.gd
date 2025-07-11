class_name DungeonTransitionScreen
extends Control

static var ui_string: UIString = null
static var TEXT: Array

static func initialize() -> void:
    ui_string = CardGame.languagePack.get_ui_string("DungeonTransitionScreen")
    TEXT = ui_string.TEXT


func _ready() -> void:
    await CardGame.black_mask.fading_out
    print("finished")
    CardGame.enable_input("button")