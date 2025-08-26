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