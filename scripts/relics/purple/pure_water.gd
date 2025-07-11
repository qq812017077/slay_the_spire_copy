class_name PureWater
extends AbstractRelic

static var ID: String = "PureWater"

func _init() -> void:
	super(ID, "clean_water.png", RelicTier.STARTER, LandingSound.MAGICAL)

func get_upgraded_description() -> String:
	return DESCRIPTIONS[0]

