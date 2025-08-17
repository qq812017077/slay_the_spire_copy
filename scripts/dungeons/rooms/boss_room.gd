class_name BossRoom
extends AbstractRoom


var boss_key: String
var boss_treasure_room: TreasureRoom = null

func _init() -> void:
	map_symbol = "B"
	phase = RoomPhase.COMBAT
	type = RoomType.BOSS

	load_treasure_room(TreasureRoom.new())
	boss_treasure_room.chest_type = TreasureRoom.ChestType.BOSS
	

func set_boss(_boss_key: String) -> void:
	boss_key = _boss_key
	map_img = ImageMaster.get_boss_img(boss_key)
	map_img_outline = ImageMaster.get_boss_img_outline(boss_key)

func load_treasure_room(treasure_room: TreasureRoom) -> void:
	boss_treasure_room = treasure_room

func get_card_rarity(_roll: int) -> AbstractCard.CardRarity:
	return AbstractCard.CardRarity.RARE

func on_player_entry():
	CardGame.music.silence_bgm()