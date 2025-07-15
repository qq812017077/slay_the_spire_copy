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

	generate_map(self)
	
	var boss_room: BossRoom = boss_room_node.room as BossRoom
	
	boss_room.set_boss(boss_list[monsterRng.randi_range(0, boss_list.size() - 1)])
	# boss_room.set_boss(MonsterHelper.BOSS_LEVEL1_HEXAGHOST)
	
	init_map_node = MapRoomNode.new(0, -1)
	var cur_pos = Vector2i(0, -1)
	init_map_node.set_room(EmptyRoom.new())
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

func generate_enemies() -> void:
	# TODO: generate monster
	# TODO:generate elites
	# generate boss
	boss_list.clear()
	boss_list.append(MonsterHelper.BOSS_LEVEL1_GUARDIAN)
	boss_list.append(MonsterHelper.BOSS_LEVEL1_HEXAGHOST)
	boss_list.append(MonsterHelper.BOSS_LEVEL1_SLIME)