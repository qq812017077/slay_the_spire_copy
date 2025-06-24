class_name UIString
extends Object

var TEXT: Array
var EXTRA_TEXT: Array
var TEXT_DICT: Dictionary = {}


static func parse(keywords: Dictionary) -> UIString:
	var ui_string = UIString.new()

	var keys: Array = keywords.keys()
	for key in keys:
		if key in ui_string:
			# set the property of keywordString with the value from keywords
			ui_string.set(key, keywords[key])
		else:
			push_warning("Key '%s' not found in KeywordString." % key)

	return ui_string
