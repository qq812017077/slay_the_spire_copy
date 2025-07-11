class_name CrackedCore
extends AbstractRelic

static var ID: String = "Cracked Core"

func _init() -> void:
	super(ID, "crackedOrb.png", RelicTier.STARTER, LandingSound.CLINK)

func get_upgraded_description() -> String:
	return DESCRIPTIONS[0]

