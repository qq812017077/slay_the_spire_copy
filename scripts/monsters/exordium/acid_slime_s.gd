class_name AcidSlimeS
extends AbstractMonster

static var ID = "AcidSlime_S"
static var monster_string: MonsterString = null
static var NAME : String = ""
static var MOVES: Array = []
static var DIALOG: Array = []

func _init(poision_amount: int = 0) -> void:
	if monster_string == null:
		monster_string = CardGame.languagePack.get_monster_string(ID)
		NAME = monster_string.NAME
		MOVES = monster_string.MOVES
		DIALOG = monster_string.DIALOG
	super(NAME, ID, 12, "")

	if CardGame.dungeon_main_screen.ascension_level >= 2:
		damage_list.append(DamageInfo.new(self, 4))
	else:
		damage_list.append(DamageInfo.new(self, 3))
	
	load_animation(CardGame.anim_library.acid_slime_s_anim)

func get_move(num: int)-> void:
	if CardGame.dungeon_main_screen.dungeon.aiRng.randf() < 0.5:
		set_move_default(1, Intent.ATTACK,  damage_list[0].base)
	else:
		set_move_default(2, Intent.DEBUFF,  damage_list[0].base)

