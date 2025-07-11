class_name AbstractPlayer
extends Node


enum PlayerType {IRONCLAD, THE_SILENT, DEFECT, WATCHER}

var type: PlayerType

static func initialize():
	pass

func _init(_type: PlayerType) -> void:
	type = _type

func new_instance() -> AbstractPlayer:
	return null

func get_character_info() -> CharacterInfo:
	return null

static func get_character_name(player_type: PlayerType) -> String:
	match player_type:
		PlayerType.IRONCLAD:
			return ""
		PlayerType.THE_SILENT:
			return ""
		PlayerType.DEFECT:
			return ""
		PlayerType.WATCHER:
			return ""

	return ""
static func get_character_relic(player_type: PlayerType) -> AbstractRelic:
	match player_type:
		PlayerType.IRONCLAD:
			return RelicLibrary.get_relic("Burning Blood")
			
		PlayerType.THE_SILENT:
			return RelicLibrary.get_relic("Ring of the Snake")
			
		PlayerType.DEFECT:
			return RelicLibrary.get_relic("Cracked Core")
			
		PlayerType.WATCHER:
			return RelicLibrary.get_relic("PureWater")
			
	return