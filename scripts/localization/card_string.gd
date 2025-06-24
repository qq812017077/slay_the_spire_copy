class_name CardString
extends Object

# This class is used to store localized strings for cards.
var name: String
var description: String
var upgrade_description: String
var extended_description: Array

static func parse(keywords: Dictionary) -> CardString:
	var card_string = CardString.new()

	var keys: Array = keywords.keys()
	for key in keys:
		if key.to_lower() in card_string:
			# set the property of keywordString with the value from keywords
			card_string.set(key.to_lower(), keywords[key])
		else:
			push_warning("Key '%s' not found in KeywordString." % key)

	return card_string

static func get_mock_card_string() -> CardString:
	var card_string = CardString.new()
	card_string.name = "[MISSING_TITLE]"
	card_string.description = "[MISSING_DESCRIPTION]"
	card_string.upgrade_description = "[MISSING_DESCRIPTION+]"
	card_string.extended_description = ["MISSING_0", "MISSING_1", "MISSING_2"]
	return card_string

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
	
	# convert json.data to Dictionary<String, CardString>
	if not json.data is Dictionary:
		push_error("JSON data is not a dictionary: " + str(json.data))
		return {}
	for key in json.data.keys():
		if not json.data[key] is Dictionary:
			push_error("Card data for key '" + key + "' is not a dictionary: " + str(json.data[key]))
			continue
		var card_data = json.data[key]
		var card_string = CardString.get_mock_card_string()
		card_string.name = card_data.get("name", "[MISSING_TITLE]")
		card_string.description = card_data.get("description", "[MISSING_DESCRIPTION]")
		card_string.upgrade_description = card_data.get("upgrade_description", "[MISSING_DESCRIPTION+]")
		card_string.extended_description = card_data.get("extended_description", ["MISSING_0", "MISSING_1", "MISSING_2"])
		json.data[key] = card_string
	return json.data
