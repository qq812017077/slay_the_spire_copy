class_name JawWorm
extends AbstractMonster

static var ID = "Jaw Worm"
static var monster_string: MonsterString = null
static var NAME : String = ""
static var MOVES: Array = []
static var DIALOG: Array = []

var talky: bool = false
func _init(talk: bool = false) -> void:
	if monster_string == null:
		monster_string = CardGame.languagePack.get_monster_string(ID)
		NAME = monster_string.NAME
		MOVES = monster_string.MOVES
		DIALOG = monster_string.DIALOG
	super(NAME, ID, 54, "")


	talky = talk
	load_animation(CardGame.anim_library.jaw_worm_anim)