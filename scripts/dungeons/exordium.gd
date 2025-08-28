class_name Exordium
extends AbstractDungeons


static var ui_string: UIString
static var TEXT: Array

static var ID: String = "Exordium"


static func initialize():
	ui_string = CardGame.languagePack.get_ui_string(ID)
	TEXT = ui_string.TEXT
	
func _init() -> void:
	super (TEXT[0], ID, null, [])

	fade_color = Color.hex(0x1e0f0aff)
	generate_map(self)
	var boss_room: BossRoom = boss_room_node.room as BossRoom
	
	boss_room.set_boss(boss_list[monsterRng.randi_range(0, boss_list.size() - 1)])
	# boss_room.set_boss(MonsterHelper.BOSS_LEVEL1_HEXAGHOST)
	
	init_map_node = MapRoomNode.new(0, -1)
	var cur_pos = Vector2i(0, -1)
	init_map_node.set_room(NeowRoom.new())
	for node: MapRoomNode in map[0]:
		if node.has_edges():
			var next_pos = Vector2i(node.x, node.y)
			init_map_node.add_edge(MapEdge.new(cur_pos, next_pos, false))
	
func init_chances() -> void:
	shopRoomChance = 0.05
	restRoomChance = 0.12
	treasureRoomChance = 0.0
	eventRoomChance = 0.22
	eliteRoomChance = 0.08

	smallChestChance = 50
	mediumChestChance = 33
	largeChestChance = 17

	commonRelicChance = 50
	uncommonRelicChance = 33
	rareRelicChance = 17

	colorlessRareChance = 0.3
	cardUpgradedChance = 0.0

func generate_monsters() -> void:
	# TODO: generate monster
	# TODO:generate elites
	# generate boss
	generate_weak_enemies(3)
	generate_strong_enemies(12)
	generate_elites(10)

func generate_weak_enemies(count: int) -> void:

	populate_monster_list(MonsterHelper.normalize_weights(
		[MonsterInfo.new(MonsterHelper.LEVEL1_WEAK_Cultist, 1.0), 
		MonsterInfo.new(MonsterHelper.LEVEL1_WEAK_Jaw_Worm, 1.0),
		MonsterInfo.new(MonsterHelper.LEVEL1_WEAK_2_Louse, 1.0),
		MonsterInfo.new(MonsterHelper.LEVEL1_WEAK_Small_Slimes, 1.0)]
	), count, false)

func generate_strong_enemies(count: int) -> void:
	var monsters: = MonsterHelper.normalize_weights(
		[MonsterInfo.new(MonsterHelper.LEVEL1_STRONG_Blue_Slaver, 2.0), 
		MonsterInfo.new(MonsterHelper.LEVEL1_STRONG_Gremlin_Gang, 1.0),
		MonsterInfo.new(MonsterHelper.LEVEL1_STRONG_Looter, 2.0),
		MonsterInfo.new(MonsterHelper.LEVEL1_STRONG_Large_Slime, 2.0),
		MonsterInfo.new(MonsterHelper.LEVEL1_STRONG_Lots_of_Slimes, 1.0),
		MonsterInfo.new(MonsterHelper.LEVEL1_STRONG_Exordium_Thugs, 1.5),
		MonsterInfo.new(MonsterHelper.LEVEL1_STRONG_Exordium_Wildlife, 1.5),
		MonsterInfo.new(MonsterHelper.LEVEL1_STRONG_Red_Slaver, 1.0),
		MonsterInfo.new(MonsterHelper.LEVEL1_STRONG_3_Louse, 2.0),
		MonsterInfo.new(MonsterHelper.LEVEL1_STRONG_2_Fungi_Beasts, 2.0)]
	)
	populate_first_strong_monster(monsters, generate_exclusions())
	populate_monster_list(monsters, count, false)

func generate_elites(count: int) -> void:
	populate_monster_list(MonsterHelper.normalize_weights(
	   [MonsterInfo.new(MonsterHelper.LEVEL1_ELITE_Gremlin_Bob, 1.0), 
		MonsterInfo.new(MonsterHelper.LEVEL1_ELITE_Lagavulin, 1.0),
		MonsterInfo.new(MonsterHelper.LEVEL1_ELITE_3_Sentries, 1.0)]
	), count, true)

func generate_exclusions() -> Array[String]:
	var ret: Array[String] = []
	match monster_list.back():
		MonsterHelper.LEVEL1_STRONG_Looter:
			ret.append(MonsterHelper.LEVEL1_STRONG_Exordium_Thugs)
		MonsterHelper.LEVEL1_STRONG_Blue_Slaver:
			ret.append(MonsterHelper.LEVEL1_STRONG_Red_Slaver)
			ret.append(MonsterHelper.LEVEL1_STRONG_Exordium_Thugs)
		MonsterHelper.LEVEL1_WEAK_2_Louse:
			ret.append(MonsterHelper.LEVEL1_STRONG_3_Louse)
		MonsterHelper.LEVEL1_WEAK_Small_Slimes:
			ret.append(MonsterHelper.LEVEL1_STRONG_Large_Slime)
			ret.append(MonsterHelper.LEVEL1_STRONG_Lots_of_Slimes)
	return ret

func init_boss() -> void:
	boss_list.clear()
	boss_list.append(MonsterHelper.BOSS_LEVEL1_GUARDIAN)
	boss_list.append(MonsterHelper.BOSS_LEVEL1_HEXAGHOST)
	boss_list.append(MonsterHelper.BOSS_LEVEL1_SLIME)

func init_event_list() -> void:
	event_list.append(BigFish.ID)


func init_shrine_list() -> void:
	shrine_list.append(GoldShrine.ID)
	pass
func init_card_pool() -> void:
	pass
func init_potions() -> void:
	pass