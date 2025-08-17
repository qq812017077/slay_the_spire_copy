class_name AbstractGameEffect
extends Node2D

var duration: float = 0
var starting_duration: float = 0
var is_done: bool = false
var can_recycle: bool = false
var color: Color = Color(1, 1, 1, 1)
func _process(delta: float) -> void:
    duration -= delta
    
    if duration < (starting_duration / 2):
        color.a = duration / (starting_duration / 2)

    if duration <= 0:
        is_done = true
        color.a = 0.0