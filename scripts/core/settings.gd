class_name Settings
extends Object

enum GameLanguage { ENG, ZHS }


# version
static var isBeta: bool = true

static var rootPath

static var gameConfig: ConfigFile
static var language: GameLanguage;

static var scale: float

#
static var BIG_TEXT_MODE: bool = false

# line settings 
static var manualLineBreak: bool = false
static var lineBreakViaCharacter: bool = false
static var manualAndAutoLineBreak: bool = false
static var usesOrdinal: bool = false
static var removeAtoZSort: bool = false

static func initialize(reloaded: bool = false) -> void:
	print("Initializing Settings...")
	initialize_display(reloaded)
	
	initialize_game_config(reloaded)
static func initialize_display(_reloaded: bool = false) -> void:
	if _reloaded:
		return
	
	# Initialize the scale based on the screen size
	var screenSize: Vector2i = DisplayServer.window_get_size()
	scale = min(screenSize.x / 1920.0, screenSize.y / 1080.0)
	print("Screen size: %s, Scale: %f" % [screenSize, scale])
	
static func initialize_game_config(_reloaded: bool = false) -> void:
	gameConfig = ConfigFile.new()
	var gameLangStr: Array = GameLanguage.keys()
	var configPath = "user://settings.cfg"
	if not gameConfig.load(configPath) == OK:
		gameConfig.set_value("Settings", "language", gameLangStr[GameLanguage.ZHS])
		gameConfig.save(configPath)
	
	set_language_by_string(gameConfig.get_value("Settings", "language", gameLangStr[GameLanguage.ZHS]), true)

	# save the language setting
	if not gameConfig.save(configPath) == OK:
		push_error("Failed to save settings.cfg")
	

static func set_language(key: GameLanguage, initial: bool) ->void :
	language = key
	if initial:
		match language:
			GameLanguage.ENG:
				lineBreakViaCharacter = false;
				usesOrdinal = true;
			GameLanguage.ZHS:
				manualAndAutoLineBreak = true;
				lineBreakViaCharacter = true;
				usesOrdinal = false;
				removeAtoZSort = true;

static func set_language_by_string(keyStr: String, initial: bool) -> void:
	
	match keyStr:
		"ENG":
			set_language(GameLanguage.ENG, initial)
		"ZHS":
			set_language(GameLanguage.ZHS, initial)
		_:
			push_error("Unknown language key: %s" % keyStr)
			set_language(GameLanguage.ZHS, initial)
