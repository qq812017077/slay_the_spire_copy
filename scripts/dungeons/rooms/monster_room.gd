class_name MonsterRoom
extends AbstractRoom

func _init() -> void:
	super(RoomPhase.COMBAT, "M", ImageMaster.map_node_enemy, ImageMaster.map_node_enemy_outline)


func on_player_entry():
	if monsters == null:
		monsters = CardGame.dungeon_main_screen.create_monster_for_room(self)
		monsters.init_all()