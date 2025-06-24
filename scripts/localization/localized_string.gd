class_name LocalizedString
extends Object

static var LOCALIZATION_DIR: String = "res://localization/"
static var PERIOD = null
static var cards: Dictionary = {} # string: CardString
static var keywords: Dictionary = {} # string: KeywordString
static var ui: Dictionary = {} # string: KeywordString
static var break_chars = null


func _init():
	var langPackDir : String
	
	match Settings.language:
		Settings.GameLanguage.ENG:
			langPackDir = "res://localization/eng"
		Settings.GameLanguage.ZHS:
			langPackDir = "res://localization/zhs"
	
	# Load the localization files
	var cardPath: String = langPackDir + "/cards.json"
	cards = load_json(cardPath)
	
	var keywordPath: String = langPackDir + "/keywords.json"
	keywords = load_json(keywordPath)
	
	var uiPath: String = langPackDir + "/ui.json"
	ui = load_json(uiPath)
	PERIOD = get_ui_string("Period").TEXT[0]
	print("initialized LocalizedString with %d cards and %d keywords." % [cards.size(), keywords.size()])
	
static func load_json(file_path: String) -> Dictionary:
	var file = FileAccess.open(file_path, FileAccess.READ)
	if file == null:
		push_error("Failed to open file: " + file_path)
		return {}
	
	var content = file.get_as_text()
	file.close()
	
	var json :JSON = JSON.new()
	var parse_error = json.parse(content)
	if parse_error != OK:
		push_error("Failed to parse JSON: " + json.get_error_message())
		return {}
	
	return json.data
	
	
func get_keyword_string(keywordName: String) -> KeywordString:
	if not keywords.has(keywordName) or keywords[keywordName] == null:
		push_error("Keyword not found: " + keywordName)
		return null
	
	return KeywordString.parse(keywords[keywordName])

func get_card_string(cardId: String) -> CardString:
	if not cards.has(cardId) or cards[cardId] == null:
		push_error("Card not found: " + cardId)
		return CardString.get_mock_card_string()
	
	return CardString.parse(cards[cardId])

func get_ui_string(uiName: String) -> UIString:
	if not ui.has(uiName) or ui[uiName] == null:
		push_error("ui not found: " + uiName)
		return null

	return UIString.parse(ui[uiName])
