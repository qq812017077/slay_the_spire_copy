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


	load_animation(CardGame.anim_library.acid_slime_s_anim)