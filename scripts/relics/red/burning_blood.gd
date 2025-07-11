class_name BurningBlood
extends AbstractRelic

static var ID: String = "Burning Blood"
static var HEALTH_AMT : int = 6

func _init() -> void:
	super(ID, "burningBlood.png", RelicTier.STARTER, LandingSound.MAGICAL)

func get_upgraded_description() -> String:
	return DESCRIPTIONS[0] + "6" + DESCRIPTIONS[1]
