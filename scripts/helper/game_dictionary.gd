class_name GameDictionary
extends Object

static var keyword_string: KeywordString
static var keywords: Dictionary = {} # string: String
static var parent_word: Dictionary = {} # string: String
static func initialize(languagePack: LocalizedString) -> void:
	print("Initializing Game Dictionary...")
	keyword_string = languagePack.get_keyword_string("Game Dictionary");
	if keyword_string.TEXT.size() > 0:
		keywords.set("[R]",keyword_string.TEXT[0])
		keywords.set("[G]",keyword_string.TEXT[0])
		keywords.set("[B]",keyword_string.TEXT[0])
		keywords.set("[W]",keyword_string.TEXT[0])
		keywords.set("[E]",keyword_string.TEXT[0])
	
	var property_list: Array[Dictionary] = keyword_string.get_property_list() 

	for property in property_list:
		if property.class_name != "Keyword":
			continue
		var keyword: Keyword = keyword_string.get(property["name"])
		create_dictionary_entry(keyword.NAMES, keyword.DESCRIPTION)

	
static func create_dictionary_entry(names: Array, desc: String) -> void:
	for name in names:
		if not keywords.has(name):
			keywords.set(name, desc)
			parent_word.set(name, names[0])
	
