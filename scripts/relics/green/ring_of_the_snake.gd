class_name RingOfTheSnake
extends AbstractRelic

static var ID: String = "Ring of the Snake"
static var NUM_CARDS : int = 2

func _init() -> void:
	super(ID, "snake_ring.png", RelicTier.STARTER, LandingSound.FLAT)

func get_upgraded_description() -> String:
	return DESCRIPTIONS[0] + "2" + DESCRIPTIONS[1]

