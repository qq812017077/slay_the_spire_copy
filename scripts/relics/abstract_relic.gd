class_name AbstractRelic
extends Object

enum LandingSound {CLINK, FLAT, HEAVY, MAGICAL, SOLID}
enum RelicTier {DEPRECATED, STARTER, COMMON, UNCOMMON, RARE, SPECIAL, BOSS, SHOP}

const IMG_DIR = "res://arts/slay_the_spire/images/relics/"
const OUTLINE_DIR = "res://arts/slay_the_spire/images/relics/outline/"
const L_IMG_DIR = "res://arts/slay_the_spire/images/largeRelics/"

var relicId: String
var relicStrings: RelicString = null
var DESCRIPTIONS: Array = []
var imgUrl: String = ""

var outline_img: Texture2D
var img: Texture2D
var name: String
var desc: String
var description: String
var flavorText: String
var tier: RelicTier
var landingSFX: LandingSound
var assetURL: String
static func initialize():
	pass
	
func _init(setId: String, imgName: String, _tier: RelicTier, sfx: LandingSound) -> void:
	relicId = setId
	relicStrings = CardGame.languagePack.get_relic_string(relicId)
	DESCRIPTIONS = relicStrings.DESCRIPTIONS
	imgUrl = imgName
	
	ImageMaster.loadRelicImg(setId, imgName)
	img = ImageMaster.getRelicImg(setId)
	outline_img = ImageMaster.getRelicOutlineImg(setId)
	name = relicStrings.NAME
	description = get_upgraded_description()
	flavorText = relicStrings.FLAVOR
	tier = _tier
	landingSFX = sfx
	assetURL = "res://arts/slay_the_spire/images/relics/" + imgName
	# tips.add(newPowerTip(tname, description))
	# initializeTips()


func get_upgraded_description() -> String:
	return ""

func playLandingSFX() -> void:
	match landingSFX:
		LandingSound.CLINK:
			CardGame.sound.single_play("RELIC_DROP_CLINK")
			return
		LandingSound.FLAT:
			CardGame.sound.single_play("RELIC_DROP_FLAT")
			return
		LandingSound.SOLID:
			CardGame.sound.single_play("RELIC_DROP_ROCKY")
			return
		LandingSound.HEAVY:
			CardGame.sound.single_play("RELIC_DROP_HEAVY")
			return
		LandingSound.MAGICAL:
			CardGame.sound.single_play("RELIC_DROP_MAGICAL")
			return
	CardGame.sound.single_play("RELIC_DROP_CLINK")
