class_name AbstractMonster
extends AbstractCreature


static func initialize() -> void:
    
    pass


var escaped: bool = false

func show_intent() -> void:
    pass


func escape() -> void:
    is_escaping = true
    escape_timer = 3.0

func die(trigger_relic: bool) -> void:
    pass

func is_dead_or_escaped() -> bool:
    # if is_dying 
    pass