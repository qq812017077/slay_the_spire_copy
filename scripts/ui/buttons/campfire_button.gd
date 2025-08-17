class_name CampfireButton
extends Control

enum ButtonType {REST, SMITH, TOKE, TRAIN, DIG, RECALL}

@export var type: ButtonType = ButtonType.REST
var label: String = ""
var desc: String = ""
var img: Texture2D = null
