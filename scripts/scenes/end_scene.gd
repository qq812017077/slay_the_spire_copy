class_name EndScene extends AbstractScene

const ATLAS_PATH = "res://arts/slay_the_spire/scenes/endingScene/scene.atlas"


func _init() -> void:
    super (ATLAS_PATH)

    ambiance_name = "AMBIANCE_BEYOND"