class_name MonsterGroup
extends Object


var monsters: Array[AbstractMonster] = []
var hovered_monster: AbstractMonster = null

func _init(input: Array[AbstractMonster]) -> void:
    monsters.assign(input)

func init_all() -> void:
    for m in monsters:
        m.init()

func add_monster(monster: AbstractMonster) -> void:
    monsters.push_back(monster)

func add_monster_at(idx: int , monster: AbstractMonster) -> void:
    idx = clamp(idx, 0, monsters.size())
    monsters.insert(idx, monster)

func add_spawned_monster(monster: AbstractMonster) -> void:
    monsters.push_front(monster)

func show_intent() -> void:
    for m in monsters:
        m.show_intent()

func are_monsters_dead() -> bool:
    for m: AbstractMonster in monsters:
        if not m.is_dead and not m.escaped:
            return false
    return true

func are_monsters_basically_dead() -> bool:
    for m: AbstractMonster in monsters:
        if not m.is_dying and not m.is_escaping:
            return false
    return true

func get_raondom_monster(expection: AbstractMonster, alive_only: bool, rng : RandomNumberGenerator = null) -> AbstractMonster:
    if are_monsters_basically_dead():
        return null
    
    if not expection and monsters.size() == 1:
        return monsters[0]
    
    if alive_only:
        var alive_monsters = []
        for m in monsters:
            if not m.half_dead and not m.is_dying and not m.is_escaping and (expection == null or m!= expection):
                alive_monsters.push_back(m)
        
        if alive_monsters.size() == 0:
            return null
        
        return alive_monsters[rng.randi_range(0, alive_monsters.size() - 1)]
    
    return monsters[rng.randi_range(0, monsters.size() - 1)]

func queue_monsters() -> void:
    for m: AbstractMonster in monsters:
        if not m.is_dead_or_escaped() and m.half_dead:
            CardGame.dungeon_main_screen.action_manager.monster_queue.push_back(MonsterQueueItem.new(m))
    return 

func has_monsters_escaped()-> bool:
    for m: AbstractMonster in monsters:
        if not m.escaped:
            return false
    return true

func exist_monster_escaping() -> bool:
    for m: AbstractMonster in monsters:
        if m.next_move == 99:
            return true
    return false 

func exist_monster_escaped() -> bool:
    for m: AbstractMonster in monsters:
        if m.escaped:
            return true
    return false 

func escape() -> void:
    for m: AbstractMonster in monsters:
        m.escape()