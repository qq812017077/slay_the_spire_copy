extends Node

enum GameState {
	START,
	PLAYING,
	GAME_OVER
}

var playerConfig: ConfigFile
var languagePack: LocalizedString = null

func _ready() -> void:
	# Initialize the game settings and player configuration
	create()

func create() -> void:
	print("Initializing...")
	Settings.initialize()
	
	playerConfig = SaveHelper.get_config("player");
	languagePack = LocalizedString.new()
	
	GameDictionary.initialize(languagePack)
	ImageMaster.initialize()
	ThemeHelper.initialize()
	AbstractCard.initialize()

	CardLibrary.initialize()
	
