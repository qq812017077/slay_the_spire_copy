class_name FastCardObtainEffect
extends AbstractGameEffect


var card_widget: CardWidget = null


func _init(target: CardWidget, pos: Vector2) -> void:
    card_widget = target

    duration = 0.01
    target.set_position(pos)
    CardGame.sound.single_play("CARD_SELECT")
    

func _process(delta: float) -> void:
    duration -= delta
    
    if duration <= 0:
        is_done = true
